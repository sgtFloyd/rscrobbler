require 'cgi'
require 'digest/md5'
require 'json'
require 'libxml'
require 'net/http'
require 'time'
require 'uri'

$:.unshift(File.dirname(__FILE__))

[
  :struct,
  :album,
  :artist,
  :auth,
  :buylink,
  :chart,
  :event,
  :geo,
  :group,
  :library,
  :playlist,
  :radio,
  :shout,
  :tag,
  :tasteometer,
  :track,
  :user,
  :venue,
  :wiki
].each{|model| require "lastfm/#{model}"}

module LastFM
  VERSION = '0.3.1'

  HOST = 'ws.audioscrobbler.com'
  API_VERSION = '2.0'

  class LastFMError < StandardError; end
  class AuthenticationError < StandardError; end

  class << self
    attr_accessor :api_key, :api_secret, :username, :auth_token, :session_key, :logger

    # Configure the module and begin a session. Once established (and successfully
    # executed), the module is ready to send api calls to Last.fm.
    #
    # @example
    #     LastFM.establish_session do |session|
    #       session.username = ...
    #       session.auth_token = ...
    #       session.api_key = ...
    #       session.api_secret = ...
    #     end
    #
    # @param [Block] &block  block used to configure the module's attributes
    # @return [String] session key if successfully connected
    # @raise [AuthenticationError] if any authentication attributes are missing
    # @raise [LastFMError] if the HTTP request to Last.fm returns an error
    def establish_session(&block)
      yield self
      self.authenticate!
    end

    # Authenticate the service with provided login credentials. Use mobile
    # authentication to avoid redirecting to the website to log in.
    #
    # @see http://www.last.fm/api/authspec last.fm auth spec
    # @return [String] session key provided from authentication
    def authenticate!
      [:api_key, :api_secret, :username, :auth_token].each do |cred|
        raise AuthenticationError, "Missing credential: #{cred}" unless LastFM.send(cred)
      end
      self.session_key = Auth.get_mobile_session( username: username, auth_token: auth_token ).find_first('session/key').content
    end

    # Has the service been authenticated?
    #
    # @return [Boolean] whether the service has been authenticated
    def authenticated?
      !!session_key
    end

    # Ensure the service has been authenticated; raise an error if it hasn't.
    #
    # @raise [AuthenticationError] if the service hasn't been authenticated.
    def requires_authentication
      raise AuthenticationError, 'LastFM Authentication Required' unless authenticated?
    end

    # Generate auth token from username and given password.
    #
    # @param [String] password  password to use
    # @return [String] md5 digest of the username and password
    def generate_auth_token( password )
      self.auth_token = Digest::MD5.hexdigest( username + Digest::MD5.hexdigest(password) )
    end

    # Construct an HTTP GET call from params, and load the response into a LibXML Document.
    #
    # @param [String] method  last.fm api method to call
    # @param [Boolean] secure  whether to sign the request with a method signature and session key
    #   (one exception being auth methods, which require a method signature but no session key)
    # @param [Hash] params  parameters to send, excluding method, api_key, api_sig, and sk
    # @return [LibXML::XML::Document] xml document of the data contained in the response
    # @raise [LastFMError] if the request fails
    def get( method, params = {}, secure = false )
      path = generate_path(method, secure, params)
      logger.debug( "Last.fm HTTP GET: #{HOST}#{path}" ) if logger
      response = Net::HTTP.get_response( HOST, path )
      validate( LibXML::XML::Parser.string( response.body ).parse )
    end

    # Construct an HTTP POST call from params, and check the response status.
    #
    # @param [String] method  last.fm api method to call
    # @param [Hash] params  parameters to send, excluding method, api_key, api_sig, and sk
    # @return [LibXML::XML::Document] xml document of the data contained in the response
    # @raise [LastFMError] if the request fails
    def post( method, params )
      post_uri = URI.parse("http://#{HOST}/#{API_VERSION}/")
      params = construct_params( method, :secure, params )
      logger.debug( "Last.fm HTTP POST: #{post_uri}, #{params.to_s}" ) if logger
      response = Net::HTTP.post_form( post_uri, params )
      validate( LibXML::XML::Parser.string( response.body ).parse )
    end

  private

    # Check an XML document for status = failed, and throw a descriptive error if it's found.
    #
    # @param [LibXML::XML::Document] xml  xml document to check for errors
    # @return [LibXML::XML::Document] the xml document if no errors were found
    # @raise [LastFMError] if an error is found
    # @private
    def validate( xml )
      raise LastFMError, xml.find_first('error').content if xml.root.attributes['status'] == 'failed'
      xml
    end

    # Normalize the parameter list by converting boolean values to 0 or 1, array values to
    # comma-separated strings, and all other values to a string. Remove any nil values, and
    # camel-case the parameter keys. Add method, api key, session key, and api signature
    # parameters where necessary.
    #
    # @param [String] method  last.fm api method
    # @param [Boolean] secure  whether to include session key and api signature in the parameters
    # @param [Hash] params  parameters to normalize and add to
    # @return [Hash] complete, normalized parameters
    # @private
    def construct_params( method, secure, params )
      params = params.each_with_object({}) do |(k,v), h|
        v = v ? 1 : 0 if !!v == v                 # convert booleans into 0 or 1
        v = v.compact.join(',') if v.is_a?(Array) # convert arrays into comma-separated strings
        v = v.to_i if v.is_a?(Time)               # convert times into integer unix timestamps
        h[camel_case(k)] = v.to_s unless v.nil?
      end
      params['method'] = method
      params['api_key'] = api_key
      params['sk'] = session_key if authenticated? && secure
      params['api_sig'] = generate_method_signature( params ) if secure
      params
    end

    # Return a the camelCased version of the given string or symbol, with underscores removed,
    # word capitalized, and the first letter lower case.
    #
    # @param [String] str  the string (or symbol) to camel case
    # @return [String] the camelcased version of the given string
    def camel_case(key)
      exceptions = { playlist_id: 'playlistID', playlist_url: 'playlistURL',
        speed_multiplier: 'speed_multiplier', fingerprint_id: 'fingerprintid' }
      return exceptions[key] if exceptions.include?(key)
      camel = key.to_s.split('_').map{|s| s.capitalize}.join
      camel[0].downcase + camel[1..-1]
    end

    # Generate the path for a particular method call given params.
    #
    # @param [String] method  last.fm method to call
    # @param [Boolean] secure  whether to include session key and api signature in the call
    # @param [optional, Hash] params  parameters to include in the api call
    # @return [String] path for the api call
    # @private
    def generate_path( method, secure, params={} )
      params = construct_params( method, secure, params )
      url = "/#{API_VERSION}/?method=#{params.delete('method')}"
      params.inject(url) do |url, (key, value)|
        url << "&#{key}=#{CGI.escape value}"
      end
    end

    # Generate a method signature based on given parameters.
    #
    # @param [Hash] parameters to combine into a method signature
    # @return [String] method signature based on all the parameters
    # @see http://www.last.fm/api/authspec#8
    # @private
    def generate_method_signature( params )
      str = params.keys.sort.inject('') do |str, key|
        str << key << params[key]
      end
      Digest::MD5.hexdigest( str << api_secret )
    end

  end
end

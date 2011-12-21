require 'digest/md5'
require 'libxml'
require 'net/http'
require 'uri'

$:.unshift(File.dirname(__FILE__))

require 'lastfm/album'
require 'lastfm/artist'
require 'lastfm/auth'
require 'lastfm/chart'
require 'lastfm/event'
require 'lastfm/geo'
require 'lastfm/group'
require 'lastfm/library'
require 'lastfm/playlist'
require 'lastfm/radio'
require 'lastfm/tag'
require 'lastfm/tasteometer'
require 'lastfm/track'
require 'lastfm/user'
require 'lastfm/venue'

module LastFM
  VERSION = '0.0.2'

  HOST = 'ws.audioscrobbler.com'
  POST_URI = URI.parse("http://#{HOST}/2.0/")

  class RequestError < StandardError; end
  class AuthenticationError < StandardError; end

  class << self

    attr_accessor :api_key, :api_secret, :username, :auth_token
    attr_reader   :session_key, :logger

    # Authenticate the service with provided login credentials. Use mobile
    # authentication to avoid redirecting to the website to log in.
    #
    # @see http://www.last.fm/api/authspec last.fm auth spec
    # @return [String] session key provided from authentication
    def authenticate!
      %w[api_key api_secret username auth_token].each do |cred|
        raise AuthenticationError, "Missing credential: #{cred}" unless LastFM.send(cred)
      end
      @session_key = Auth.get_mobile_session( username, auth_token ).find_first('session/key').content
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
      self.auth_token = Digest::MD5.hexdigest( username.dup << Digest::MD5.hexdigest(password) )
    end

    # Construct an HTTP GET call from params, and load the response into a LibXML Document.
    #
    # @param [String] method  last.fm api method to call
    # @param [optional, Boolean] secure  whether sign the request with a method signature and session key
    #   (one exception being auth methods, which require a method signature but no session key)
    # @param [Hash] params  parameters to send, excluding method, api_key, api_sig, and sk
    # @return [LibXML::XML::Document] xml document of the data contained in the response
    # @raise [LastFMError] if the request fails
    def get( method, secure = false, params = {} )
      path = generate_path(method, secure, params)
      logger.debug( "Last.fm HTTP GET: #{HOST+path}" ) if logger
      response = Net::HTTP.get_response( HOST, path )
      check_status( LibXML::XML::Parser.string( response.body ).parse )
    end

    # Construct an HTTP POST call from params, and check the response status.
    #
    # @param [String] method  last.fm api method to call
    # @param [Hash] params  parameters to send, excluding method, api_key, api_sig, and sk
    # @return [LibXML::XML::Document] xml document of the data contained in the response
    # @raise [LastFMError] if the request fails
    def post( method, params )
      params = construct_params( method, :secure, params )
      logger.debug( "Last.fm HTTP POST: #{POST_URI}, #{params.to_s}" ) if logger
      response = Net::HTTP.post_form( POST_URI, params )
      check_status( LibXML::XML::Parser.string( response.body ).parse )
    end

  private

    # Check an XML document for status = failed, and throw a descriptive error if it's found.
    #
    # @param [LibXML::XML::Document] xml  xml document to check for errors
    # @return [LibXML::XML::Document] the xml document if no errors were found
    # @raise [LastFMError] if an error is found
    # @private
    def check_status( xml )
      raise RequestError, xml.find_first('error').content if xml.root.attributes['status'] == 'failed'
      xml
    end

    # Normalize the parameter list by converting values to a string and removing any nils. Add method,
    # api key, session key, and api signature parameters where necessary.
    #
    # @param [String] method  last.fm api method
    # @param [Boolean] secure  whether to include session key and api signature in the parameters
    # @param [Hash] params  parameters to normalize and add to
    # @return [Hash] complete, normalized parameters
    def construct_params( method, secure, params )
      params.delete_if{|k,v| v.nil? }
      params.each{|k,v| params[k] = params[k].to_s }
      params['method'] = method
      params['api_key'] = api_key
      params['sk'] = session_key if authenticated? && secure
      params['api_sig'] = generate_method_signature( params ) if secure
      params
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
      url = "/2.0/?method=#{params.delete('method')}"
      params.keys.each do |key|
        url << "&#{key}=#{params[key]}"
      end
      URI.encode(url)
    end

    # Generate a method signature based on given parameters.
    #
    # @param [Hash] parameters to combine into a method signature
    # @return [String] method signature based on all the parameters
    # @see http://www.last.fm/api/authspec#8
    # @private
    def generate_method_signature( params )
      str = ''
      params.keys.sort.each do |key|
        str << key << params[key]
      end
      Digest::MD5.hexdigest( str << api_secret )
    end

  end
end

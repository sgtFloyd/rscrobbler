module LastFM
  class Auth
    class << self

      TYPE = 'auth'

      # Create a web service session for a user. Used for authenticating a user when the
      # password can be inputted by the user. Only suitable for standalone mobile devices.
      #
      # @option params [String, required] :username     last.fm username
      # @option params [String, required] :auth_token   md5 hash of the username + the password hash
      # @see http://www.last.fm/api/show?service=266
      def get_mobile_session( params )
        LastFM.get( "#{TYPE}.getMobileSession", params, :secure )
      end

      # Fetch a session key for a user. The third step in the authentication process.
      #
      # @option params [String, required] :token    md5 hash returned by step 1 of the authentication process
      # @see http://www.last.fm/api/show?service=125
      def get_session( params )
        LastFM.get( "#{TYPE}.getSession", params, :secure )
      end

      # Fetch an unathorized request token for an API account. This is step 2 of
      # the authentication process for desktop applications.
      #
      # @see http://www.last.fm/api/show?service=265
      def get_token
        LastFM.get( "#{TYPE}.getToken", {}, :secure )
      end

    end
  end
end
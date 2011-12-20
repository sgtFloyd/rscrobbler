module LastFM
  class Auth
    class << self

      TYPE = 'auth'

      # @see http://www.last.fm/api/show?service=266
      def get_mobile_session( username, auth_token )
        LastFM.get( "#{TYPE}.getMobileSession", :secure, 'username' => username, 'authToken' => auth_token )
      end
    
      # @see http://www.last.fm/api/show?service=125
      def get_session( token )
        LastFM.get( "#{TYPE}.getSession", :secure )
      end
    
      # @see http://www.last.fm/api/show?service=265
      def get_token()
        LastFM.get( "#{TYPE}.getToken", :secure )
      end

    end
  end
end
module LastFM
  class Event
    class << self

      TYPE = 'event'

      # @see http://www.last.fm/api/show?service=307
      def attend( event, status )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.attend", 'event'=>event, 'status'=>status )
      end
    
      # @see http://www.last.fm/api/show?service=391
      def get_attendees( event, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getAttendees", !:secure, 'event'=>event, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=292
      def get_info( event )
        LastFM.get( "#{TYPE}.getInfo", !:secure, 'event'=>event )
      end
    
      # @see http://www.last.fm/api/show?service=399
      def get_shouts( event, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getShouts", !:secure, 'event'=>event, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=350
      def share( event, recipient, message = nil, public = nil )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.share", 'event'=>event, 'recipient'=>recipient, 'public'=>public, 'message'=>message )
      end
    
      # @see http://www.last.fm/api/show?service=409
      def shout( event, message )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", 'event'=>event, 'message'=>message )
      end

    end
  end
end
module LastFM
  class Venue
    class << self

      TYPE = 'venue'

      # @see http://www.last.fm/api/show?service=394
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=395
      def get_past_events( params )
        LastFM.get( "#{TYPE}.getPastEvents", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=396
      def search( params )
        LastFM.get( "#{TYPE}.search", !:secure, params )
      end

    end
  end 
end
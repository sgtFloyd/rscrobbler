module LastFM
  class Venue
    class << self

      TYPE = 'venue'

      # @see http://www.last.fm/api/show?service=394
      def get_events( venue, festivals_only = nil )
        LastFM.get( "#{TYPE}.getEvents", !:secure, 'venue'=>venue, 'festivalsonly'=>festivals_only )
      end

      # @see http://www.last.fm/api/show?service=395
      def get_past_events( venue, festivals_only = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getPastEvents", !:secure, 'venue'=>venue, 'festivalsonly'=>festivals_only, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=396
      def search( venue, country = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.search", !:secure, 'venue'=>venue, 'country'=>country, 'limit'=>limit, 'page'=>page )
      end

    end
  end 
end
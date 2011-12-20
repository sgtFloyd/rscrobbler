module LastFM
  class Geo
    class << self

      TYPE = 'geo'

      # @see http://www.last.fm/api/show?service=270
      def get_events( location = nil, lat = nil, long = nil, distance = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getEvents", !:secure, 'location'=>location, 'lat'=>lat, 'long'=>long, 'distance'=>distance, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=421
      def get_metro_artist_chart( country, metro, time_start = nil, time_end = nil )
        LastFM.get( "#{TYPE}.getMetroArtistChart", !:secure, 'country'=>country, 'metro'=>metro, 'start'=>time_start, 'end'=>time_end )
      end
    
      # @see http://www.last.fm/api/show?service=420
      def get_metro_hype_artist_chart( country, metro, time_start = nil, time_end = nil )
        LastFM.get( "#{TYPE}.getMetroHypeArtistChart", !:secure, 'country'=>country, 'metro'=>metro, 'start'=>time_start, 'end'=>time_end )
      end
    
      # @see http://www.last.fm/api/show?service=422
      def get_metro_hype_track_chart( country, metro, time_start = nil, time_end = nil )
        LastFM.get( "#{TYPE}.getMetroHypeTrackChart", !:secure, 'country'=>country, 'metro'=>metro, 'start'=>time_start, 'end'=>time_end )
      end
    
      # @see http://www.last.fm/api/show?service=423
      def get_metro_track_chart( country, metro, time_start = nil, time_end = nil )
        LastFM.get( "#{TYPE}.getMetroTrackChart", !:secure, 'country'=>country, 'metro'=>metro, 'start'=>time_start, 'end'=>time_end )
      end
    
      # @see http://www.last.fm/api/show?service=424
      def get_metro_unique_artist_chart( country, metro, time_start = nil, time_end = nil )
        LastFM.get( "#{TYPE}.getMetroUniqueArtistChart", !:secure, 'country'=>country, 'metro'=>metro, 'start'=>time_start, 'end'=>time_end )
      end
    
      # @see http://www.last.fm/api/show?service=425
      def get_metro_unique_track_chart( country, metro, time_start = nil, time_end = nil )
        LastFM.get( "#{TYPE}.getMetroUniqueTrackChart", !:secure, 'country'=>country, 'metro'=>metro, 'start'=>time_start, 'end'=>time_end )
      end
    
      # @see http://www.last.fm/api/show?service=426
      def get_metro_weekly_chartlist( metro )
        LastFM.get( "#{TYPE}.getMetroWeeklyChartlist", !:secure, 'metro'=>metro )
      end
    
      # @see http://www.last.fm/api/show?service=435
      def get_metros( country = nil )
        LastFM.get( "#{TYPE}.getMetros", !:secure, 'country'=>country )
      end
    
      # @see http://www.last.fm/api/show?service=297
      def get_top_artists( country, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, 'country'=>country, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=298
      def get_top_tracks( country, location = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, 'country'=>country, 'location'=>location, 'limit'=>limit, 'page'=>page )
      end

    end
  end
end
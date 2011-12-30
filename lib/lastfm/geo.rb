module LastFM
  class Geo
    class << self

      TYPE = 'geo'

      # Get all events in a specific location by country or city name.
      #
      # @see http://www.last.fm/api/show?service=270
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", !:secure, params )
      end

      # Get a chart of artists for a metro.
      #
      # @see http://www.last.fm/api/show?service=421
      def get_metro_artist_chart( params )
        LastFM.get( "#{TYPE}.getMetroArtistChart", !:secure, params )
      end

      # Get a chart of hyped (up and coming) artists for a metro.
      #
      # @see http://www.last.fm/api/show?service=420
      def get_metro_hype_artist_chart( params )
        LastFM.get( "#{TYPE}.getMetroHypeArtistChart", !:secure, params )
      end

      # Get a chart of hyped (up and coming) tracks for a metro.
      #
      # @see http://www.last.fm/api/show?service=422
      def get_metro_hype_track_chart( params )
        LastFM.get( "#{TYPE}.getMetroHypeTrackChart", !:secure, params )
      end

      # Get a chart of tracks for a metro.
      #
      # @see http://www.last.fm/api/show?service=423
      def get_metro_track_chart( params )
        LastFM.get( "#{TYPE}.getMetroTrackChart", !:secure, params )
      end

      # Get a chart of the artists which make that metro unique
      #
      # @see http://www.last.fm/api/show?service=424
      def get_metro_unique_artist_chart( params )
        LastFM.get( "#{TYPE}.getMetroUniqueArtistChart", !:secure, params )
      end

      # Get a chart of the tracks which make that metro unique
      #
      # @see http://www.last.fm/api/show?service=425
      def get_metro_unique_track_chart( params )
        LastFM.get( "#{TYPE}.getMetroUniqueTrackChart", !:secure, params )
      end

      # Get a list of available chart periods for this metro, expressed as date ranges which can be sent to the chart services.
      #
      # @see http://www.last.fm/api/show?service=426
      def get_metro_weekly_chartlist( params )
        LastFM.get( "#{TYPE}.getMetroWeeklyChartlist", !:secure, params )
      end

      # Get a list of valid countries and metros for use in the other webservices
      #
      # @see http://www.last.fm/api/show?service=435
      def get_metros( params )
        LastFM.get( "#{TYPE}.getMetros", !:secure, params )
      end

      # Get the most popular artists on Last.fm by country
      #
      # @see http://www.last.fm/api/show?service=297
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, params )
      end

      # Get the most popular tracks on Last.fm by country
      #
      # @see http://www.last.fm/api/show?service=298
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, params )
      end

    end
  end
end
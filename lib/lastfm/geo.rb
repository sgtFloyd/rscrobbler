module LastFM
  class Geo
    class << self

      TYPE = 'geo'

      # Get all events in a specific location by country or city name.
      #
      # @option params [String, optional] :location   location to retrieve events for
      # @option params [String, optional] :lat        latitude value to retrieve events for
      # @option params [String, optional] :long       longitude value to retrieve events for
      # @option params [Fixnum, optional] :distance   find events within a specified radius (in kilometres)
      # @option params [Fixnum, optional] :page       the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit      the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=270
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", !:secure, params )
      end

      # Get a chart of artists for a metro.
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, required] :metro      the metro's name
      # @option params [String, optional] :start      beginning timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @option params [String, optional] :end        ending timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=421
      def get_metro_artist_chart( params )
        LastFM.get( "#{TYPE}.getMetroArtistChart", params )
      end

      # Get a chart of hyped (up and coming) artists for a metro.
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, required] :metro      the metro's name
      # @option params [String, optional] :start      beginning timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @option params [String, optional] :end        ending timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=420
      def get_metro_hype_artist_chart( params )
        LastFM.get( "#{TYPE}.getMetroHypeArtistChart", params )
      end

      # Get a chart of hyped (up and coming) tracks for a metro.
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, required] :metro      the metro's name
      # @option params [String, optional] :start      beginning timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @option params [String, optional] :end        ending timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=422
      def get_metro_hype_track_chart( params )
        LastFM.get( "#{TYPE}.getMetroHypeTrackChart", params )
      end

      # Get a chart of tracks for a metro.
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, required] :metro      the metro's name
      # @option params [String, optional] :start      beginning timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @option params [String, optional] :end        ending timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=423
      def get_metro_track_chart( params )
        LastFM.get( "#{TYPE}.getMetroTrackChart", params )
      end

      # Get a chart of the artists which make that metro unique
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, required] :metro      the metro's name
      # @option params [String, optional] :start      beginning timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @option params [String, optional] :end        ending timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=424
      def get_metro_unique_artist_chart( params )
        LastFM.get( "#{TYPE}.getMetroUniqueArtistChart", params )
      end

      # Get a chart of the tracks which make that metro unique
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, required] :metro      the metro's name
      # @option params [String, optional] :start      beginning timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @option params [String, optional] :end        ending timestamp of the weekly range requested (see: Geo.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=425
      def get_metro_unique_track_chart( params )
        LastFM.get( "#{TYPE}.getMetroUniqueTrackChart", params )
      end

      # Get a list of available chart periods for this metro, expressed as date ranges which can be sent to the chart services.
      #
      # @option params [String, required] :metro    metro name to fetch the charts list for
      # @see http://www.last.fm/api/show?service=426
      def get_metro_weekly_chartlist( params )
        LastFM.get( "#{TYPE}.getMetroWeeklyChartlist", params )
      end

      # Get a list of valid countries and metros for use in the other webservices
      #
      # @option params [String, optional] :country    restrict results to metros from a particular country, as defined by ISO 3166-1
      # @see http://www.last.fm/api/show?service=435
      def get_metros( params )
        LastFM.get( "#{TYPE}.getMetros", params )
      end

      # Get the most popular artists on Last.fm by country
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [Fixnum, optional] :page       the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit      the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=297
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", params )
      end

      # Get the most popular tracks on Last.fm by country
      #
      # @option params [String, required] :country    a country name, as defined by ISO 3166-1
      # @option params [String, optional] :location   location to fetch the charts for
      # @option params [Fixnum, optional] :page       the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit      the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=298
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", params )
      end

    end
  end
end
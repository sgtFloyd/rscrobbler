module LastFM
  class Tag
    class << self

      TYPE = 'tag'

      # @see http://www.last.fm/api/show?service=452
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=311
      def get_similar( params )
        LastFM.get( "#{TYPE}.getSimilar", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=283
      def get_top_albums( params )
        LastFM.get( "#{TYPE}.getTopAlbums", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=284
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=276
      def get_top_tags
        LastFM.get( "#{TYPE}.getTopTags", !:secure )
      end

      # @see http://www.last.fm/api/show?service=285
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", params )
      end

      # @see http://www.last.fm/api/show?service=358
      def get_weekly_artist_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=359
      def get_weekly_chart_list( params )
        LastFM.get( "#{TYPE}.getWeeklyChartList", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=273
      def search( params )
        LastFM.get( "#{TYPE}.search", !:secure, params )
      end

    end
  end 
end
module LastFM
  class Tag
    class << self

      TYPE = 'tag'

      # @see http://www.last.fm/api/show?service=452
      def get_info( tag, lang = nil )
        LastFM.get( "#{TYPE}.getInfo", !:secure, 'tag'=>tag, 'lang'=>lang )
      end

      # @see http://www.last.fm/api/show?service=311
      def get_similar( tag )
        LastFM.get( "#{TYPE}.getSimilar", !:secure, 'tag'=>tag )
      end

      # @see http://www.last.fm/api/show?service=283
      def get_top_albums( tag, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopAlbums", !:secure, 'tag'=>tag, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=284
      def get_top_artists( tag, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, 'tag'=>tag, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=276
      def get_top_tags
        LastFM.get( "#{TYPE}.getTopTags", !:secure  )
      end

      # @see http://www.last.fm/api/show?service=285
      def get_top_tracks( tag, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, 'tag'=>tag, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=358
      def get_weekly_artist_chart( tag, time_from = nil, time_to = nil, limit = nil )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", !:secure, 'tag'=>tag, 'from'=>time_from, 'to'=>time_to, 'limit'=>limit )
      end

      # @see http://www.last.fm/api/show?service=359
      def get_weekly_chart_list( tag )
        LastFM.get( "#{TYPE}.getWeeklyChartList", !:secure, 'tag'=>tag )
      end

      # @see http://www.last.fm/api/show?service=273
      def search( tag, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.search", !:secure, 'tag'=>tag, 'limit'=>limit, 'page'=>page )
      end

    end
  end 
end
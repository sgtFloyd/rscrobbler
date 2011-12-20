module LastFM
  class Chart
    class << self

      TYPE = 'chart'

      # @see http://www.last.fm/api/show?service=493
      def get_hyped_artists( limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getHypedArtists", !:secure, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=494
      def get_hyped_tracks( limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getHypedTracks", !:secure, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=495
      def get_loved_tracks( limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getLovedTracks", !:secure, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=496
      def get_top_artists( limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=497
      def get_top_tags( limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopTags", !:secure, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show?service=498
      def get_top_tracks( limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, 'limit'=>limit, 'page'=>page )
      end

    end
  end
end
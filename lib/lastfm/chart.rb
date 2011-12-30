module LastFM
  class Chart
    class << self

      TYPE = 'chart'

      # Get the hyped artists chart
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=493
      def get_hyped_artists( params )
        LastFM.get( "#{TYPE}.getHypedArtists", !:secure, params )
      end

      # Get the hyped tracks chart
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=494
      def get_hyped_tracks( params )
        LastFM.get( "#{TYPE}.getHypedTracks", !:secure, params )
      end

      # Get the most loved tracks chart
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=495
      def get_loved_tracks( params )
        LastFM.get( "#{TYPE}.getLovedTracks", !:secure, params )
      end

      # Get the top artists chart
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=496
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, params )
      end

      # Get the top tags chart
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=497
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", !:secure, params )
      end

      # Get the top tracks chart
      #
      # @option params [Fixnum, optional] :page   the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit  the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=498
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, params )
      end

    end
  end
end
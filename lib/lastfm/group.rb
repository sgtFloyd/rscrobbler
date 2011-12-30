module LastFM
  class Group
    class << self

      TYPE = 'group'

      # @see http://www.last.fm/api/show?service=259
      def get_hype( params )
        LastFM.get( "#{TYPE}.getHype", params )
      end
    
      # @see http://www.last.fm/api/show/?service=379
      def get_members( params )
        LastFM.get( "#{TYPE}.getMembers", params )
      end
    
      # @see http://www.last.fm/api/show/?service=293
      def get_weekly_album_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyAlbumChart", params )
      end
    
      # @see http://www.last.fm/api/show/?service=294
      def get_weekly_artist_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", params )
      end
    
      # @see http://www.last.fm/api/show/?service=295
      def get_weekly_chart_list( params )
        LastFM.get( "#{TYPE}.getWeeklyChartList", params )
      end
    
      # @see http://www.last.fm/api/show/?service=296
      def get_weekly_track_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyTrackChart", params )
      end

    end
  end
end

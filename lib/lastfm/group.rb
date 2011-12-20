module LastFM
  class Group
    class << self

      TYPE = 'group'

      # @see http://www.last.fm/api/show?service=259
      def get_hype( group )
        LastFM.get( "#{TYPE}.getHype", !:secure, 'group'=>group )
      end
    
      # @see http://www.last.fm/api/show/?service=379
      def get_members( group, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getMembers", !:secure, 'group'=>group, 'limit'=>limit, 'page'=>page )
      end
    
      # @see http://www.last.fm/api/show/?service=293
      def get_weekly_album_chart( group, date_from = nil, date_to = nil )
        LastFM.get( "#{TYPE}.getWeeklyAlbumChart", !:secure, 'group'=>group, 'from'=>date_from, 'to'=>date_to )
      end
    
      # @see http://www.last.fm/api/show/?service=294
      def get_weekly_artist_chart( group, date_from = nil, date_to = nil )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", !:secure, 'group'=>group, 'from'=>date_from, 'to'=>date_to )
      end
    
      # @see http://www.last.fm/api/show/?service=295
      def get_weekly_chart_list( group )
        LastFM.get( "#{TYPE}.getWeeklyChartList", !:secure, 'group'=>group )
      end
    
      # @see http://www.last.fm/api/show/?service=296
      def get_weekly_track_chart( group, date_from = nil, date_to = nil )
        LastFM.get( "#{TYPE}.getWeeklyTrackChart", !:secure, 'group'=>group, 'from'=>date_from, 'to'=>date_to )
      end

    end
  end
end

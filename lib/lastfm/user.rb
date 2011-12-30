module LastFM
  class User
    class << self

      TYPE = 'user'

      # @see http://www.last.fm/api/show?service=432
      def get_artist_tracks( params )
        LastFM.get( "#{TYPE}.getArtistTracks", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=448
      def get_banned_tracks( params )
        LastFM.get( "#{TYPE}.getBannedTracks", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=291
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=263
      def get_friends( params )
        LastFM.get( "#{TYPE}.getFriends", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=344
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=329
      def get_loved_tracks( params )
        LastFM.get( "#{TYPE}.getLovedTracks", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=264
      def get_neighbors( params )
        LastFM.get( "#{TYPE}.getNeighbonrs", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=444
      def get_new_releases( params )
        LastFM.get( "#{TYPE}.getNewReleases", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=343
      def get_past_events( params )
        LastFM.get( "#{TYPE}.getPastEvents", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=455
      def get_personal_tags( params )
        LastFM.get( "#{TYPE}.getPersonalTags", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=313
      def get_playlists( params )
        LastFM.get( "#{TYPE}.getPlaylists", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=414
      def get_recent_stations( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecentStations", :secure, params )
      end

      # @see http://www.last.fm/api/show?service=278
      def get_recent_tracks( params )
        LastFM.get( "#{TYPE}.getRecentTracks", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=388
      def get_recommended_artists( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedArtists", :secure, params )
      end

      # @see http://www.last.fm/api/show?service=375
      def get_recommended_events( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedEvents", :secure, params )
      end

      # @see http://www.last.fm/api/show?service=401
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=299
      def get_top_albums( params )
        LastFM.get( "#{TYPE}.getTopAlbums", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=300
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=123
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=301
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=279
      def get_weekly_album_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyAlbumChart", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=281
      def get_weekly_artist_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=280
      def get_weekly_chart_list( params )
        LastFM.get( "#{TYPE}.getWeeklyChartList", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=282
      def get_weekly_track_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyTrackChart", !:secure, params )
      end

      # @see http://www.last.fm/api/show?service=411
      def shout( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", params )
      end

    end
  end 
end
module LastFM
  class User
    class << self

      TYPE = 'user'

      # @see http://www.last.fm/api/show?service=432
      def get_artist_tracks( params )
        LastFM.get( "#{TYPE}.getArtistTracks", params )
      end

      # @see http://www.last.fm/api/show?service=448
      def get_banned_tracks( params )
        LastFM.get( "#{TYPE}.getBannedTracks", params )
      end

      # @see http://www.last.fm/api/show?service=291
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", params )
      end

      # @see http://www.last.fm/api/show?service=263
      def get_friends( params )
        LastFM.get( "#{TYPE}.getFriends", params )
      end

      # @see http://www.last.fm/api/show?service=344
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", params )
      end

      # @see http://www.last.fm/api/show?service=329
      def get_loved_tracks( params )
        LastFM.get( "#{TYPE}.getLovedTracks", params )
      end

      # @see http://www.last.fm/api/show?service=264
      def get_neighbors( params )
        LastFM.get( "#{TYPE}.getNeighbonrs", params )
      end

      # @see http://www.last.fm/api/show?service=444
      def get_new_releases( params )
        LastFM.get( "#{TYPE}.getNewReleases", params )
      end

      # @see http://www.last.fm/api/show?service=343
      def get_past_events( params )
        LastFM.get( "#{TYPE}.getPastEvents", params )
      end

      # @see http://www.last.fm/api/show?service=455
      def get_personal_tags( params )
        LastFM.get( "#{TYPE}.getPersonalTags", params )
      end

      # @see http://www.last.fm/api/show?service=313
      def get_playlists( params )
        LastFM.get( "#{TYPE}.getPlaylists", params )
      end

      # @see http://www.last.fm/api/show?service=414
      def get_recent_stations( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecentStations", params. :secure )
      end

      # @see http://www.last.fm/api/show?service=278
      def get_recent_tracks( params )
        LastFM.get( "#{TYPE}.getRecentTracks", params )
      end

      # @see http://www.last.fm/api/show?service=388
      def get_recommended_artists( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedArtists", params, :secure )
      end

      # @see http://www.last.fm/api/show?service=375
      def get_recommended_events( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedEvents", params, :secure )
      end

      # @see http://www.last.fm/api/show?service=401
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", params, :secure )
      end

      # @see http://www.last.fm/api/show?service=299
      def get_top_albums( params )
        LastFM.get( "#{TYPE}.getTopAlbums", params )
      end

      # @see http://www.last.fm/api/show?service=300
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", params )
      end

      # @see http://www.last.fm/api/show?service=123
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", params )
      end

      # @see http://www.last.fm/api/show?service=301
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", params )
      end

      # @see http://www.last.fm/api/show?service=279
      def get_weekly_album_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyAlbumChart", params )
      end

      # @see http://www.last.fm/api/show?service=281
      def get_weekly_artist_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", params )
      end

      # @see http://www.last.fm/api/show?service=280
      def get_weekly_chart_list( params )
        LastFM.get( "#{TYPE}.getWeeklyChartList", params )
      end

      # @see http://www.last.fm/api/show?service=282
      def get_weekly_track_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyTrackChart", params )
      end

      # @see http://www.last.fm/api/show?service=411
      def shout( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", params )
      end

    end
  end 
end
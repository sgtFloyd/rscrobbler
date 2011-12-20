module LastFM
  class User
    class << self

      TYPE = 'user'

      # @see http://www.last.fm/api/show?service=432
      def get_artist_tracks( user, artist, start_timestamp = nil, end_timestamp = nil, page = nil )
        LastFM.get( "#{TYPE}.getArtistTracks", !:secure, 'user'=>user, 'artist'=>artist, 'startTimestamp'=>start_timestamp, 'endTimestamp'=>end_timestamp, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=448
      def get_banned_tracks( user, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getBannedTracks", !:secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=291
      def get_events( user, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getEvents", !:secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=263
      def get_friends( user, recent_tracks = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getFriends", !:secure, 'user'=>user, 'recenttracks'=>recent_tracks, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=344
      def get_info( user = nil )
        LastFM.get( "#{TYPE}.getInfo", !:secure, 'user'=>user )
      end

      # @see http://www.last.fm/api/show?service=329
      def get_loved_tracks( user, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getLovedTracks", !:secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=264
      def get_neighbors( user, limit = nil )
        LastFM.get( "#{TYPE}.getNeighbonrs", !:secure, 'user'=>user, 'limit'=>limit )
      end

      # @see http://www.last.fm/api/show?service=444
      def get_new_releases( user, useresc = nil )
        LastFM.get( "#{TYPE}.getNewReleases", !:secure, 'user'=>user, 'useresc'=>useresc )
      end

      # @see http://www.last.fm/api/show?service=343
      def get_past_events( user, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getPastEvents", !:secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      @tagging_types = [ 'artist', 'album', 'track' ]

      # @see http://www.last.fm/api/show?service=455
      def get_personal_tags( user, tag, tagging_type, limit = nil, page = nil )
        raise ArgumentError unless @tagging_types.include?(tagging_type)
        LastFM.get( "#{TYPE}.getPersonalTags", !:secure, 'user'=>user, 'tag'=>tag, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=313
      def get_playlists( user )
        LastFM.get( "#{TYPE}.getPlaylists", !:secure, 'user'=>user )
      end

      # @see http://www.last.fm/api/show?service=414
      def get_recent_stations( user, limit = nil, page = nil )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecentStations", :secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=278
      def get_recent_tracks( user, time_from = nil, time_to = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getRecentTracks", !:secure, 'user'=>user, 'from'=>time_from, 'to'=>time_to, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=388
      def get_recommended_artists( limit = nil, page = nil )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedArtists", :secure, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=375
      def get_recommended_events( limit = nil, page = nil )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedEvents", :secure, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=401
      def get_shouts( user, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getShouts", !:secure, 'user'=>user, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=299
      def get_top_albums( user, period = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopAlbums", !:secure, 'user'=>user, 'period'=>period, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=300
      def get_top_artists( user, period = nil, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopArtists", !:secure, 'user'=>user, 'period'=>period, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=123
      def get_top_tags( user, limit = nil )
        LastFM.get( "#{TYPE}.getTopTags", !:secure, 'user'=>user, 'limit'=>limit )
      end

      # @see http://www.last.fm/api/show?service=301
      def get_top_tracks( user, period, limit = nil, page = nil )
        LastFM.get( "#{TYPE}.getTopTracks", !:secure, 'user'=>user, 'period'=>period, 'limit'=>limit, 'page'=>page )
      end

      # @see http://www.last.fm/api/show?service=279
      def get_weekly_album_chart( user, time_from = nil, time_to = nil )
        LastFM.get( "#{TYPE}.getWeeklyAlbumChart", !:secure, 'user'=>user, 'from'=>time_from, 'to'=>time_to )
      end

      # @see http://www.last.fm/api/show?service=281
      def get_weekly_artist_chart( user, time_from = nil, time_to = nil )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", !:secure, 'user'=>user, 'from'=>time_from, 'to'=>time_to )
      end

      # @see http://www.last.fm/api/show?service=280
      def get_weekly_chart_list( user )
        LastFM.get( "#{TYPE}.getWeeklyChartList", !:secure, 'user'=>user )
      end

      # @see http://www.last.fm/api/show?service=282
      def get_weekly_track_chart( user, time_from = nil, time_to = nil )
        LastFM.get( "#{TYPE}.getWeeklyTrackChart", !:secure, 'user'=>user, 'from'=>time_from, 'to'=>time_to )
      end

      # @see http://www.last.fm/api/show?service=411
      def shout( user, message )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", 'user'=>user, 'message'=>message )
      end

    end
  end 
end
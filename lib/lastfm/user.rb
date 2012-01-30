module LastFM
  class User
    class << self

      TYPE = 'user'

      # Get a list of tracks by a given artist scrobbled by this user,
      # including scrobble time. Can be limited to specific timeranges,
      # defaults to all time.
      #
      # @option params [String, required] :user             last.fm username to fetch the recent tracks for
      # @option params [String, required] :artist           the artist name to fetch tracks for
      # @option params [String, optional] :startTimestamp   a unix timestamp to start at
      # @option params [String, optional] :endTimestamp     a unix timestamp to end at
      # @option params [Fixnum, optional] :page             the page number to fetch. defaults to first page
      # @see http://www.last.fm/api/show?service=432
      def get_artist_tracks( params )
        # TODO: accept Time objects and convert to unix timestamp
        LastFM.get( "#{TYPE}.getArtistTracks", params )
      end

      # Get a list of tracks banned by a user.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=448
      def get_banned_tracks( params )
        LastFM.get( "#{TYPE}.getBannedTracks", params )
      end

      # Get a list of upcoming events that this user is attending.
      #
      # @option params [String,  required] :user            last.fm username
      # @option params [Boolean, optional] :festivalsonly   whether only festivals should be returned, or all events
      # @option params [Fixnum,  optional] :page            the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional] :limit           the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=291
      def get_events( params )
        LastFM.get( "#{TYPE}.getEvents", params )
      end

      # Get a list of the user's friends on Last.fm.
      #
      # @option params [String,  required] :user            last.fm username
      # @option params [Boolean, optional] :recenttracks    whether or not to include information about friends' recent listening in the response.
      # @option params [Fixnum,  optional] :page            the page number to fetch. defaults to first page
      # @option params [Fixnum,  optional] :limit           the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=263
      def get_friends( params )
        LastFM.get( "#{TYPE}.getFriends", params )
      end

      # Get information about a user profile.
      #
      # @option params [String, optional] :user   user to fetch info for. defaults to the authenticated user
      # @see http://www.last.fm/api/show?service=344
      def get_info( params )
        LastFM.get( "#{TYPE}.getInfo", params )
      end

      # Get a list of tracks loved by a user.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=329
      def get_loved_tracks( params )
        LastFM.get( "#{TYPE}.getLovedTracks", params )
      end

      # Get a list of a user's neighbours on Last.fm.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=264
      def get_neighbors( params )
        LastFM.get( "#{TYPE}.getNeighbonrs", params )
      end

      # Gets a list of upcoming releases based on a user's musical taste.
      #
      # @option params [String,  required] :user      last.fm username
      # @option params [Boolean, optional] :userecs   if true, return new releases based on artist recommendations. otherwise, it is based on their library (the default)
      # @see http://www.last.fm/api/show?service=444
      def get_new_releases( params )
        LastFM.get( "#{TYPE}.getNewReleases", params )
      end

      # Get a list of all events a user has attended in the past.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=343
      def get_past_events( params )
        LastFM.get( "#{TYPE}.getPastEvents", params )
      end

      # Get the user's personal tags.
      #
      # @option params [String, required] :user           last.fm username
      # @option params [String, required] :tag            the tag you're interested in
      # @option params [String, required] :taggingtype    the type of items which have been tagged. accepted types are 'artist', 'album', or 'track'
      # @option params [Fixnum, optional] :page           the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit          the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=455
      def get_personal_tags( params )
        LastFM.get( "#{TYPE}.getPersonalTags", params )
      end

      # Get a list of a user's playlists.
      #
      # @option params [String, required] :user   last.fm username
      # @see http://www.last.fm/api/show?service=313
      def get_playlists( params )
        LastFM.get( "#{TYPE}.getPlaylists", params )
      end

      # Get a list of the recent Stations listened to by a user.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=414
      def get_recent_stations( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecentStations", params, :secure )
      end

      # Get a list of the recent tracks listened to by a user. Also includes
      # the currently playing track with the nowplaying="true" attribute if
      # the user is currently listening.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :from     display scrobbles after this time, formatted as unix UTC integer timestamp
      # @option params [String, optional] :to       display scrobbles before this time, formatted as unix UTC integer timestamp
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=278
      def get_recent_tracks( params )
        # TODO: accept Time objects and convert to unix timestamp
        LastFM.get( "#{TYPE}.getRecentTracks", params )
      end

      # Get Last.fm artist recommendations for a user.
      #
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=388
      def get_recommended_artists( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedArtists", params, :secure )
      end

      # Get a paginated list of all events recommended to a user by Last.fm, based on their listening profile.
      #
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=375
      def get_recommended_events( params )
        LastFM.requires_authentication
        LastFM.get( "#{TYPE}.getRecommendedEvents", params, :secure )
      end

      # Get shouts for a user.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=401
      def get_shouts( params )
        LastFM.get( "#{TYPE}.getShouts", params, :secure )
      end

      # Get the top albums listened to by a user, based on an optional time period.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :period   time period over which to retrieve top albums for. accepted values are 'overall', '7day', '3month', '6month' or '12month'
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=299
      def get_top_albums( params )
        LastFM.get( "#{TYPE}.getTopAlbums", params )
      end

      # Get the top artists listened to by a user, based on an optional time period.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :period   time period over which to retrieve top artists for. accepted values are 'overall', '7day', '3month', '6month' or '12month'
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=300
      def get_top_artists( params )
        LastFM.get( "#{TYPE}.getTopArtists", params )
      end

      # Get the top tags used by a user.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=123
      def get_top_tags( params )
        LastFM.get( "#{TYPE}.getTopTags", params )
      end

      # Get the top tracks listened to by a user, based on an optional time period.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :period   time period over which to retrieve top tracks for. accepted values are 'overall', '7day', '3month', '6month' or '12month'
      # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
      # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
      # @see http://www.last.fm/api/show?service=301
      def get_top_tracks( params )
        LastFM.get( "#{TYPE}.getTopTracks", params )
      end

      # Get an album chart for a user, for a given date range. Defaults to the most recent chart.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :from     date at which the chart should start. (see: User.get_weekly_chart_list)
      # @option params [String, optional] :to       date at which the chart should end. (see: User.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=279
      def get_weekly_album_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyAlbumChart", params )
      end

      # Get an artist chart for a user, for a given date range. Defaults to the most recent chart.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :from     date at which the chart should start. (see: User.get_weekly_chart_list)
      # @option params [String, optional] :to       date at which the chart should end. (see: User.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=281
      def get_weekly_artist_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyArtistChart", params )
      end

      # Get a list of available charts for this user, expressed as date ranges which can be sent to the chart services.
      #
      # @option params [String, required] :user   last.fm username
      # @see http://www.last.fm/api/show?service=280
      def get_weekly_chart_list( params )
        LastFM.get( "#{TYPE}.getWeeklyChartList", params )
      end

      # Get a track chart for a user, for a given date range. Defaults to the most recent chart.
      #
      # @option params [String, required] :user     last.fm username
      # @option params [String, optional] :from     date at which the chart should start. (see: User.get_weekly_chart_list)
      # @option params [String, optional] :to       date at which the chart should end. (see: User.get_weekly_chart_list)
      # @see http://www.last.fm/api/show?service=282
      def get_weekly_track_chart( params )
        LastFM.get( "#{TYPE}.getWeeklyTrackChart", params )
      end

      # Shout on a user's shoutbox.
      #
      # @option params [String, required] :user       user to shout on
      # @option params [String, required] :message    message to post to the shoutbox
      # @see http://www.last.fm/api/show?service=411
      def shout( params )
        LastFM.requires_authentication
        LastFM.post( "#{TYPE}.shout", params )
      end

    end
  end 
end
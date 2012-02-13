module LastFM
  module Api
    class Group
      class << self

        # Get the hype list for a group.
        #
        # @option params [String, required] :group    the last.fm group name
        # @see http://www.last.fm/api/show?service=259
        def get_hype( params )
          LastFM.get( "group.getHype", params )
        end

        # Get the list of members for a group.
        #
        # @option params [String, required] :group    the last.fm group name
        # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
        # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
        # @see http://www.last.fm/api/show/?service=379
        def get_members( params )
          LastFM.get( "group.getMembers", params )
        end

        # Get an album chart for a group, for a given date range. If no date range
        # is supplied, return the most recent.
        #
        # @option params [String, required] :group    the last.fm group name
        # @option params [Time,   optional] :from     date at which the chart should start from (see: Group.get_weekly_chart_list)
        # @option params [Time,   optional] :to       date at which the chart should end on (see: Group.get_weekly_chart_list)
        # @see http://www.last.fm/api/show/?service=293
        def get_weekly_album_chart( params )
          LastFM.get( "group.getWeeklyAlbumChart", params )
        end

        # Get an artist chart for a group, for a given date range. If no date range
        # is supplied, return the most recent.
        #
        # @option params [String, required] :group    the last.fm group name
        # @option params [Time,   optional] :from     date at which the chart should start from (see: Group.get_weekly_chart_list)
        # @option params [Time,   optional] :to       date at which the chart should end on (see: Group.get_weekly_chart_list)
        # @see http://www.last.fm/api/show/?service=294
        def get_weekly_artist_chart( params )
          LastFM.get( "group.getWeeklyArtistChart", params )
        end

        # Get the list of available charts for a group, expressed as date ranges
        # which can be sent to the chart services.
        #
        # @option params [String, required] :group    the last.fm group name
        # @see http://www.last.fm/api/show/?service=295
        def get_weekly_chart_list( params )
          LastFM.get( "group.getWeeklyChartList", params )
        end

        # Get a track chart for a group, for a given date range. If no date range
        # is supplied, return the most recent.
        #
        # @option params [String, required] :group    the last.fm group name
        # @option params [Time,   optional] :from     date at which the chart should start from (see: Group.get_weekly_chart_list)
        # @option params [Time,   optional] :to       date at which the chart should end on (see: Group.get_weekly_chart_list)
        # @see http://www.last.fm/api/show/?service=296
        def get_weekly_track_chart( params )
          LastFM.get( "group.getWeeklyTrackChart", params )
        end

      end
    end
  end
end

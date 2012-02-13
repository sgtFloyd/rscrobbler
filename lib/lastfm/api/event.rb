module LastFM
  module Api
    class Event
      class << self

        # Set a user's attendance status for an event.
        #
        # @option params [Fixnum, required] :event    numeric last.fm event id
        # @option params [Symbol, required] :status   attendance status. accepted values are :attending, :maybe_attending, and :not_attending
        # @see http://www.last.fm/api/show?service=307
        def attend( params )
          LastFM.requires_authentication
          status_codes = { attending: 0, maybe_attending: 1, not_attending: 2 }
          params[:status] = status_codes[params[:status]] if params.include?(:status)
          LastFM.post( "event.attend", params )
        end

        # Get a list of attendees for an event.
        #
        # @option params [Fixnum, required] :event    numeric last.fm event id
        # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
        # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
        # @see http://www.last.fm/api/show?service=391
        def get_attendees( params )
          LastFM.get( "event.getAttendees", params )
        end

        # Get the metadata for an event on Last.fm. Includes attendance and lineup information.
        #
        # @option params [Fixnum, required] :event    numeric last.fm event id
        # @see http://www.last.fm/api/show?service=292
        def get_info( params )
          LastFM.get( "event.getInfo", params )
        end

        # Get shouts for an event.
        #
        # @option params [Fixnum, required] :event    numeric last.fm event id
        # @option params [Fixnum, optional] :page     the page number to fetch. defaults to first page
        # @option params [Fixnum, optional] :limit    the number of results to fetch per page. defaults to 50
        # @see http://www.last.fm/api/show?service=399
        def get_shouts( params )
          LastFM.get( "event.getShouts", params )
        end

        # Share an event with one or more Last.fm users or other friends.
        #
        # @option params [Fixnum,  required] :event       numeric last.fm event id
        # @option params [Array,   required] :recipient   a list of email addresses or Last.fm usernames. maximum is 10
        # @option params [String,  optional] :message     an optional message to send. if not supplied a default message will be used
        # @option params [Boolean, optional] :public      optionally show in the sharing users activity feed. defaults to false
        # @see http://www.last.fm/api/show?service=350
        def share( params )
          LastFM.requires_authentication
          LastFM.post( "event.share", params )
        end

        # Shout in an event's shoutbox.
        #
        # @option params [Fixnum, required] :event      numeric last.fm event id
        # @option params [String, required] :message    message to post to the shoutbox
        # @see http://www.last.fm/api/show?service=409
        def shout( params )
          LastFM.requires_authentication
          LastFM.post( "event.shout", params )
        end

      end
    end
  end
end
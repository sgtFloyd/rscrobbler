module LastFM

  # @attr [Fixnum] id
  # @attr [String] title
  # @attr [String] headliner
  # @attr [Array<String>] artists
  # @attr [LastFM::Venue] venue
  # @attr [Time] start_date
  # @attr [String] description
  # @attr [Hash] images
  # @attr [Fixnum] attendance
  # @attr [Fixnum] reviews
  # @attr [String] tag
  # @attr [String] url  Last.fm url for the event
  # @attr [String] website  Event website (different from Last.fm url)
  # @attr [Boolean] cancelled
  # @attr [Array<String>] tags
  class Event < Struct.new(:id, :title, :headliner, :artists, :venue, :start_date, :description, :images, :attendance, :reviews, :tag, :url, :website, :cancelled, :tags)

    def update_from_node(node)
      case node.name.to_sym
        when :id
          self.id = node.content.to_i
        when :title
          self.title = node.content
        when :artists # nested artists and headliner
          node.find('*').each{|child| self.update_from_node(child)}
        when :artist
          self.artists ||= []
          self.artists << node.content
        when :headliner
          self.headliner = node.content
        when :venue
          self.venue = LastFM::Venue.from_xml( node )
        when :startDate
          self.start_date = Time.parse(node.content) rescue nil
        when :description
          self.description = node.content
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
        when :attendance
          self.attendance = node.content.to_i
        when :reviews
          self.reviews = node.content.to_i
        when :tag
          self.tag = node.content
        when :url
          self.url = node.content
        when :website
          self.website = node.content
        when :tickets
          # ???
        when :cancelled
          self.cancelled = (node.content == '1')
        when :tags
          self.tags = node.find('*').each{|tag| tag.content}
      end
    end

    # API Methods
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

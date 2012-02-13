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
          self.start_date = Time.parse(node.content)
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

  end
end

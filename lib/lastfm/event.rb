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
  # @attr [String] url
  # @attr [String] website
  # @attr [Boolean] cancelled
  # @attr [Array<String>] tags
  class Event < Struct.new(:id, :title, :headliner, :artists, :venue, :start_date, :description, :images, :attendance, :reviews, :tag, :url, :website, :cancelled, :tags)

    def update_from_node(node)
      case node.name.to_sym
        when :id
          self.id = node.content.to_i
      end
    end

  end
end

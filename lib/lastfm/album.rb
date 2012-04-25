module LastFM

  # @attr [LastFM::Artist, String] artist
  # @attr [Fixnum] id
  # @attr [Hash] images
  # @attr [Fixnum] listeners
  # @attr [String] mbid
  # @attr [String] name
  # @attr [Fixnum] playcount
  # @attr [Time] release_date
  # @attr [Boolean] streamable
  # @attr [Array<LastFM::Tag>] tags
  # @attr [Array<LastFM::Track>] tracks
  # @attr [String] url
  # @attr [LastFM::Wiki] wiki
  class Album < Struct.new(:artist, :id, :images, :listeners, :mbid, :name, :playcount, :release_date, :streamable, :tags, :tracks, :url, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name, :title
          self.name = node.content
        when :artist
          self.artist = (node.find('*').count == 0) ? node.content : LastFM::Artist.from_xml(node)
        when :id
          self.id = node.content.to_i
        when :mbid
          self.mbid = node.content
        when :url
          self.url = node.content
        when :releasedate
          self.release_date = Time.parse(node.content) rescue nil
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
        when :listeners
          self.listeners = node.content.to_i
        when :playcount
          self.playcount = node.content.to_i
        when :streamable
          self.streamable = (node.content == '1')
        when :tracks
          self.tracks = node.find('track').map do |track|
            LastFM::Track.from_xml(track, :album => self.name, :position => track['rank'].to_i)
          end
        when :toptags
          self.tags = node.find('tag').map do |tag|
            LastFM::Tag.from_xml(tag)
          end
        when :wiki
          self.wiki = LastFM::Wiki.from_xml(node)
      end
    end

  end
end

module LastFM

  # @attr [LastFM::Album] album
  # @attr [LastFM::Artist, String] artist
  # @attr [Fixnum] duration
  # @attr [Fixnum] id
  # @attr [Hash] images
  # @attr [Fixnum] listeners
  # @attr [String] mbid
  # @attr [String] name
  # @attr [Fixnum] playcount
  # @attr [Fixnum] position
  # @attr [Boolean] streamable
  # @attr [Boolean] streamable_fulltrack
  # @attr [Array] tags
  # @attr [String] url
  # @attr [LastFM::Wii] wiki
  class Track < Struct.new(:album, :artist, :duration, :id, :images, :listeners, :mbid, :name, :playcount, :position, :streamable, :streamable_fulltrack, :tags, :url, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name
          self.name = node.content
        when :id
          self.id = node.content.to_i
        when :duration
          self.duration = node.content.to_i
        when :mbid
          self.mbid = node.content
        when :url
          self.url = node.content
        when :listeners
          self.listeners = node.content.to_i
        when :playcount
          self.playcount = node.content.to_i
        when :streamable
          self.streamable = (node.content == '1')
          self.streamable_fulltrack = (node['fulltrack'] == '1')
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
        when :artist
          self.artist = (node.find('*').count == 0) ? node.content : LastFM::Artist.from_xml(node)
        when :album
          self.position = node['position'].to_i
          self.album = LastFM::Album.from_xml(node)
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
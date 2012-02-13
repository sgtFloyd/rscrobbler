module LastFM

  # @attr [Hash] images
  # @attr [Fixnum] listeners
  # @attr [String] mbid
  # @attr [String] name
  # @attr [Fixnum] playcount
  # @attr [Array] similar
  # @attr [Boolean] streamable
  # @attr [Array] tags
  # @attr [String]  url
  # @attr [LastFM::Wiki] wiki
  class Artist < Struct.new(:images, :listeners, :mbid, :name, :playcount, :similar, :streamable, :tags, :url, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name
          self.name = node.content
        when :mbid
          self.mbid = node.content
        when :url
          self.url = node.content
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
        when :streamable
          self.streamable = (node.content == '1')
        when :listeners
          self.listeners = node.content.to_i
        when :playcount
          self.playcount = node.content.to_i
        when :stats # nested listeners and playcount
          node.find('*').each{|child| self.update_from_node(child)}
        when :similar
          self.similar = node.find('artist').map do |artist|
            LastFM::Artist.from_xml(artist)
          end
        when :tags
          self.tags = node.find('tag').map do |tag|
            LastFM::Tag.from_xml(tag)
          end
        when :bio
          self.wiki = LastFM::Wiki.from_xml(node)
      end
    end

  end
end
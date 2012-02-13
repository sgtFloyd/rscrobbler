module LastFM

  # @attr [String] name
  # @attr [Fixnum] count
  # @attr [String] url
  # @attr [Fixnum] reach
  # @attr [Boolean] streamable
  # @attr [LastFM::Wiki] wiki
  class Tag < Struct.new(:name, :count, :url, :reach, :streamable, :wiki)

    def update_from_node(node)
      case node.name.to_sym
        when :name
          self.name = node.content
        when :url
          self.url = node.content
        when :reach
          self.reach = node.content.to_i
        when :count, :taggings
          self.count = node.content.to_i
        when :streamable
          self.streamable = (node.content == '1')
        when :wiki
          self.wiki = LastFM::Wiki.from_xml(node)
      end
    end

  end
end
module LastFM

  # @attr [Time] published  Date the information in this entry was published
  # @attr [String] summary  Short summary of the information in this entry
  # @attr [String] content  Full content of this entry
  class Wiki < Struct.new(:published, :summary, :content)

    def update_from_node(node)
      case node.name.to_sym
        when :published
          self.published = Time.parse(node.content) rescue nil
        when :summary #TODO: Remove CDATA wrapper
          self.summary = node.content
        when :content #TODO: Remove CDATA wrapper
          self.content = node.content
      end
    end

  end
end

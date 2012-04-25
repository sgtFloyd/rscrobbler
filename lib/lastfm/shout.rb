module LastFM

  # @attr [String] author
  # @attr [String] body
  # @attr [Time] date
  class Shout < Struct.new(:author, :body, :date)

    def update_from_node(node)
      case node.name.to_sym
        when :author
          self.author = node.content
        when :body
          self.body = node.content
        when :date
          self.date = Time.parse(node.content) rescue nil
      end
    end

  end
end

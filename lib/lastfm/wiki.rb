module LastFM

  # @attr [Time]   published  Date the information in this entry was published
  # @attr [String] summary    Short summary of the information in this entry
  # @attr [String] content    Full content of this entry
  class Wiki < Struct.new(:published, :summary, :content)
    class << self

      def attr_from_node(node)
        attr = node.name.to_sym
        case attr
          when :summary, :content
            { attr => node.content.to_s }
          when :published
            { attr => Time.parse(node.content.to_s) }
          else
            {}
        end
      end

    end
  end
end

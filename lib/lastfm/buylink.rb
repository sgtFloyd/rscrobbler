module LastFM

  # @attr [Symbol] type  whether the link is for a physical purchase, or a download
  # @attr [Hash] supplier
  # @attr [Hash] price
  # @attr [String] link
  # @attr [Boolean] is_search
  class Buylink < Struct.new(:type, :supplier, :price, :link, :is_search)

    def update_from_node(node)
      case node.name.to_sym
        when :supplierName
          self.supplier ||= {}
          self.supplier[:name] = node.content
        when :supplierIcon
          self.supplier ||= {}
          self.supplier[:icon] = node.content
        when :price # nested price & currency
          node.find('*').each{|child| self.update_from_node(child)}
        when :amount
          self.price ||= {}
          self.price[:amount] = node.content.to_f
        when :currency
          self.price ||= {}
          self.price[:currency] = node.content
        when :buyLink
          self.link = node.content
        when :isSearch
          self.is_search = (node.content == '1')
      end
    end

  end
end

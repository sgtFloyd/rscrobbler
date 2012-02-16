module LastFM
  class Venue < Struct.new(:id, :name, :location, :url, :website, :phone_number, :images)

    def update_from_node(node)
      case node.name.to_sym
        when :id
          self.id = node.content.to_i
        when :name
          self.name = node.content
        when :location
          # ??? city, country, street, postalcode, geo:lat, geo:long
        when :url
          self.url = node.content
        when :website
          self.website = node.content
        when :phoneNumber
          self.phone_number = node.content
        when :image
          self.images ||= {}
          self.images.merge!({node['size'].to_sym => node.content})
      end
    end

  end
end

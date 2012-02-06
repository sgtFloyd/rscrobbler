module LastFM

  # @attr [Time]   published  Date the information in this entry was published
  # @attr [String] summary    Short summary of the information in this entry
  # @attr [String] content    Full content of this entry
  class Wiki < Struct.new(:published, :summary, :content)
    class << self

      def from_xml(xml)
        attributes = {}
        self.new(attributes)
      end

      # TODO: Make this inherited into every LastFM::Struct subclass
      # Convert an XML::Node to an XML::Document for use with the from_xml constructor.
      #
      # @param [LibXML::XML::Node] xml_node   XML node to convert to an XML document
      # @return [Wiki] the result of self.from_xml constructor
      def from_node(xml_node)
        return NotImplementedError unless self.respond_to?(:from_xml)
        xml_doc = LibXML::XML::Parser.string(xml_node.to_s).parse
        self.from_xml(xml_doc)
      end

    end
  end
end

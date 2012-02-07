module LastFM

  # Prodives modifications to Ruby's Struct class for use within the LastFM module space.
  # Must be called 'Struct' to play nice with YARD's @attr documentation.
  class Struct < Struct

    # Override Struct's initialize method to accept a hash of members instead.
    def initialize(h={})
      members.each{|m| self[m] = h[m.to_sym]}
    end

    # Get the Last.fm package name for a Ruby class
    #
    # @return [String] the Last.fm package name
    def self.package
      self.to_s.downcase.split('::').last
    end

    # Construct a LastFM::Struct object from XML, using each inheritor's attr_from_node
    # method to determine how to manipulate individual attributes.
    #
    # @param [LibXML::XML::Document] xml  XML obtained from a Last.fm API call
    # @return [LastFM::Struct] object contructed from attributes contained in XML
    def self.from_xml(xml)
      raise NotImplementedError unless self.respond_to?(:attr_from_node)
      attributes = {}
      xml.find("#{self.package}/*").each do |node|
        new_attr = self.attr_from_node(node)
        # recursively merge hash attributes one level deep. Rails' Hash#deep_merge! would be handy
        attributes.merge!(new_attr){|k,ov,nv| ov.is_a?(Hash) ? ov.merge(nv) : nv}
      end
      self.new(attributes)
    end

    # Convert an XML node to a parsed XML doc for use with from_xml.
    #
    # @param [LibXML::XML::Node] node   XML node to convert to an XML document
    # @return [LastFM::Struct] the result passing the parsed node to from_xml.
    def self.from_node(node)
      xml_doc = LibXML::XML::Parser.string(xml_node.to_s).parse
      self.from_xml(xml_doc)
    end

  end
end

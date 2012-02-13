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
    # @param [Hash] initial_attributes  Attributes to set before parsing the XML
    # @return [LastFM::Struct] object contructed from attributes contained in XML
    def self.from_xml(xml, initial_attributes={})
      raise NotImplementedError unless self.method_defined?(:update_from_node)
      xml = xml.find_first(self.package) if xml.is_a?(LibXML::XML::Document)
      model = self.new(initial_attributes)
      xml.find('*').each{|child| model.update_from_node(child)}
      model
    end

  end
end

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
      # construct LastFM:: objects from an XML document using class-specific rules
    end

  end
end

module LastFM

  # Prodives modifications to Ruby's Struct class for use within the LastFM module space.
  # Must be called 'Struct' to play nice with YARD's @attr documentation.
  class Struct < Struct

    def self.inherited(child)
      child.class_eval do
        members.each do |mem|
          # Override member= methods to filter through parse_node when given an XML::Node
          define_method(:"#{mem}=") do |val|
            val = parse_node(mem, val) if val.is_a?(LibXML::XML::Node)
            super val
          end
        end if public_methods.include?(:members)
      end

      super
    end

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
      xml = xml.find_first(self.package) if xml.is_a?(LibXML::XML::Document)
      model = self.new(initial_attributes)
      xml.find('*').each{|node|
        if self.method_defined?(:update_from_node)
          model.update_from_node(node)
        else
          model.send(:"#{node.name}=", node)
        end
      }
      model
    end

    def to_json(*a)
      members.inject({}){|map, m|
        map[m] = self[m]; map
      }.to_json(*a)
    end

  end
end

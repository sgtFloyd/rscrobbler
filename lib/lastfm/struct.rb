module LastFM

  # Prodives modifications to Ruby's Struct class for use within the LastFM module space.
  # Must be called 'Struct' to play nice with YARD's @attr documentation.
  class Struct < Struct

    # Override Struct's initialize method to accept a hash of members instead.
    def initialize(h={})
      members.each{|m| self[m] = h[m.to_sym]}
    end

  end
end

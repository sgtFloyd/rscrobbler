module LastFM

  # @attr [Time]   published  Date the information in this entry was published
  # @attr [String] summary    Short summary of the information in this entry
  # @attr [String] content    Full content of this entry
  class Wiki < Struct.new(:published, :summary, :content)
    class << self

    end
  end
end

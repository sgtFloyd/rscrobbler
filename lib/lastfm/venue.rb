module LastFM
  class Venue < Struct.new(:id, :name, :location, :url, :website, :phone_number, :images)
  end
end

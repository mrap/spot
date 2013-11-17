require 'mongoid_geospatial'

class Mongoid::Geospatial::Point
  def longitude
    self.to_hsh[:x]
  end

  def latitude
    self.to_hsh[:y]
  end
end

# makes life a little easier
class Coordinates < Mongoid::Geospatial::Point
end

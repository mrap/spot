require 'mongoid_geospatial'

class Mongoid::Geospatial::Point

  def longitude
    self.to_hsh[:x]
  end

  def latitude
    self.to_hsh[:y]
  end

end

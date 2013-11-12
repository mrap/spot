class Location
  MILES_PER_ARCDEG = 69
  KILOMETERS_PER_ARCDEG = 111

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial

  geo_field :coordinates
  validates_presence_of :coordinates

  def nearby
    Location.geo_near(self.coordinates.to_a)
  end

  def nearby_with_distance(options)
    distance = options[:miles].fdiv(MILES_PER_ARCDEG) if options[:miles]
    distance = options[:kilometers].fdiv(KILOMETERS_PER_ARCDEG) if options[:kilometers]
    distance = distance || options || 0
    nearby.max_distance(distance)
  end
end

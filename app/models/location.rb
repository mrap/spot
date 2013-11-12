class Location
  MILES_PER_ARCDEG = 69
  KILOMETERS_PER_ARCDEG = 111
  METERS_PER_MILE = 1609.344

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial

  geo_field :coordinates
  validates_presence_of :coordinates

  def nearby
    Location.geo_near(self.coordinates.to_a)
  end

  def nearby_with_distance(options)
    distance =   Location.miles_to_arcdeg(options[:miles]) if options[:miles]
    distance =   Location.kilometers_to_arcdeg(options[:kilometers]) if options[:kilometers]
    distance ||= options || 0
    nearby.max_distance(distance)
  end

  def distance_to(to_location, unit_type = { miles: true })
    from     = Vincenty.new(self.latitude, self.longitude)
    to       = Vincenty.new(to_location.latitude, to_location.longitude)
    distance = from.distanceAndAngle(to).distance

    if unit_type[:kilometers]
      Location.meters_to_kilometers(distance)
    else
      Location.meters_to_miles(distance)
    end
  end

  def longitude
    self.coordinates.to_hsh[:x]
  end

  def latitude
    self.coordinates.to_hsh[:y]
  end

  private

    # Helpers
    def self.miles_to_arcdeg(miles)
      miles.fdiv(MILES_PER_ARCDEG)
    end

    def self.kilometers_to_arcdeg(kilometers)
      kilometers.fdiv(KILOMETERS_PER_ARCDEG)
    end

    def self.meters_to_miles(meters)
      meters.fdiv(METERS_PER_MILE)
    end

    def self.meters_to_kilometers(meters)
      meters.fdiv(1000)
    end

end

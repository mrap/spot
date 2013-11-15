class Location
  MILES_PER_ARCDEG = 69
  KILOMETERS_PER_ARCDEG = 111
  METERS_PER_ARCDEG = 111_000
  METERS_PER_MILE = 1609.344

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial

  geo_field :coordinates
  validates_presence_of :coordinates

  scope :nearby,  ->(location) { Location.near(coordinates: location.coordinates)  }

  def nearby
    Location.nearby(self)
  end

  def nearby_within_distance_with_limit(distance = ENV['DEFAULT_SEARCH_RADIUS'], limit = nil)
    # Convert meters to arcdeg
    distance = Location.meters_to_arcdeg(distance)

    if limit
      Location.nearby(self).max_distance(coordinates: distance).limit(limit)
    else
      Location.nearby(self).max_distance(coordinates: distance)
    end
  end

  def distance_to(to_location)
    from     = Vincenty.new(self.latitude, self.longitude)
    to       = Vincenty.new(to_location.latitude, to_location.longitude)
    return from.distanceAndAngle(to).distance
  end

  def longitude
    self.coordinates.longitude
  end

  def latitude
    self.coordinates.latitude
  end

  private

    # Helpers

    def self.miles_to_arcdeg(miles)
      miles.fdiv(MILES_PER_ARCDEG)
    end

    def self.kilometers_to_arcdeg(kilometers)
      kilometers.fdiv(KILOMETERS_PER_ARCDEG)
    end

    def self.meters_to_arcdeg(meters)
      meters.fdiv(METERS_PER_ARCDEG)
    end

    def self.meters_to_miles(meters)
      meters.fdiv(METERS_PER_MILE)
    end

    def self.meters_to_kilometers(meters)
      meters.fdiv(1000)
    end

end

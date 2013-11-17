class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  METERS_PER_ARCDEG = 111_000

  has_many :posts
  field :posts_count,       type: Integer,    default: 0

  field :name,              type: String
  field :address,           type: String
  field :address_extended,  type: String
  field :neighborhood,      type: String
  field :locality,          type: String
  field :region,            type: String
  field :country,           type: String
  field :postcode,          type: String
  geo_field :coordinates

  validates_presence_of :name, :coordinates

  scope :most_posts, ->{ order_by(posts_count: :desc) }

  def self.nearby_coordinates(coordinates, options = {})
    if options[:radius] && options[:radius] > 0
      radius = Place.meters_to_arcdeg(options[:radius])
      Place.near(coordinates: coordinates).max_distance(coordinates: radius)
    else
      Place.near(coordinates: coordinates)
    end
  end

  def distance_to_coordinates(coordinates)
    from     = Vincenty.new(self.latitude, self.longitude)
    to       = Vincenty.new(coordinates.latitude, coordinates.longitude)
    return from.distanceAndAngle(to).distance
  end

  def longitude
    self.coordinates.longitude
  end

  def latitude
    self.coordinates.latitude
  end

  private

    def self.meters_to_arcdeg(meters)
      meters.fdiv(METERS_PER_ARCDEG)
    end

end

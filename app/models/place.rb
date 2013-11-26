class Place
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  include Mongoid::Search

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

  # Queries via full text search
  #   Place.full_text_search("some search text")
  # @return [Mongoid::Critera]
  search_in :name

  # Orders a query by Places with most posts -> least posts
  # @return [Mongoid::Critera] 
  scope :most_posts, ->{ order_by(posts_count: :desc) }

  # Queries for places located nearby given coordinates within an optional radius.
  # @param  coordinates [Coordinates] center of the query.
  # @option radius distance from center in meters.
  # @return [Mongoid::Critera]
  def self.nearby_coordinates(coordinates, options = {})
    if options[:radius]
      radius = Place.meters_to_arcdeg(options[:radius].to_f)
      Place.near(coordinates: coordinates).max_distance(coordinates: radius)
    else
      Place.near(coordinates: coordinates)
    end
  end

  # Returns the distance from a place's coordinates to other coordinates.
  # @params coordinates [Coordinates] to compare distance to.
  # @return distance [Float] in meters.
  def distance_to_coordinates(coordinates)
    from     = Vincenty.new(self.latitude, self.longitude)
    to       = Vincenty.new(coordinates.latitude, coordinates.longitude)
    return from.distanceAndAngle(to).distance
  end

  # Callback fired after_create of new post
  def post_changed_callback
    self.posts_count = self.posts.count
  end

  # Returns place's longitude
  def longitude
    self.coordinates.longitude
  end

  # Returns place's latitude
  def latitude
    self.coordinates.latitude
  end

  private

    # Converts meters to arc degrees
    # @param meters
    # @return arc degrees
    def self.meters_to_arcdeg(meters)
      meters.fdiv(METERS_PER_ARCDEG)
    end

end

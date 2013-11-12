class Place
  METERS_PER_MILE = 1609.344

  include Mongoid::Document

  has_many :posts

  field :name,              type: String
  field :address,           type: String
  field :address_extended,  type: String
  field :neighborhood,      type: String
  field :locality,          type: String
  field :region,            type: String
  field :country,           type: String
  field :postcode,          type: String
  field :latitude,          type: Float
  field :longitude,         type: Float
  validates_presence_of :name

  def meters_from_coordinates(options = {})
    this_place  = Vincenty.new(self.latitude, self.longitude)
    other_place = Vincenty.new(options[:latitude], options[:longitude])
    this_place.distanceAndAngle(other_place).distance
  end

  def miles_from_coordinates(options = {})
    meters_from_coordinates(options) / METERS_PER_MILE
  end

end

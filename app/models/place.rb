class Place
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

end

class Place < Location
  include Mongoid::Document

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

  validates_presence_of :name

  scope :most_posts, order_by(posts_count: :desc)

end

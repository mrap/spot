class User
  include Mongoid::Document

  has_many :posts
  has_and_belongs_to_many :helpful_posts, class_name: "Post", inverse_of: :helped_users
  has_many :events, inverse_of: :initiator

  field :username, type: String
  field :score,    type: Integer, default: 0

  validates_presence_of :username
  validates_uniqueness_of :username
end

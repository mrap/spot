class User
  include Mongoid::Document

  has_many :posts

  field :username, type: String

  validates_presence_of :username
  validates_uniqueness_of :username
end

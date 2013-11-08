class Place
  include Mongoid::Document

  has_many :posts

  field :name
  validates_presence_of :name

end

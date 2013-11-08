class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :post

  field :description
end

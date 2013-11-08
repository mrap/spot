class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :description
end

class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :description
end

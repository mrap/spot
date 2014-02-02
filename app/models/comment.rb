class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post 
  belongs_to :author, class_name: "User"
  field :text, type: String
end

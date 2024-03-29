class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :post 
  belongs_to :author, class_name: "User"
  field :text, type: String

  validates_length_of :text, within: 1..300

  def serializable_hash(options = {})
    hash = super(options)
    hash[:post_id] = post.id.to_s
    hash[:author_id] = author.id.to_s
    return hash
  end
end

class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Pagination

  belongs_to :author, class_name: "User", inverse_of: :posts
  belongs_to :place
  has_and_belongs_to_many :helped_users, class_name: "User", inverse_of: :helpful_posts
  has_many :comments

  field :description
  has_mongoid_attached_file :photo,
    default_style: :original,
    styles: {
      original: ['640x640>',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' },
    dependent: :destroy
  
  # As of Paperclip v4.0.0, content type must be validated
  validates_attachment_content_type :photo, :content_type => %w(image/jpeg image/jpg image/png)

  validates_presence_of :author

  after_create  { self.place.post_added(self) }
  after_destroy { self.place.post_removed }

  scope :recent, ->{ order_by(created_at: :desc) }

  def serializable_hash(options = {})
    hash = super(options)
    hash[:author_id] = author.id.to_s if author
    hash[:author_username] = author.username if author.has_attribute? :username
    hash[:place_id] = place.id.to_s if place
    hash.delete('photo_content_type')
    hash.delete('photo_file_name')
    hash.delete('photo_file_size')
    hash.delete('photo_updated_at')
    hash[:photo_url] = self.photo.url
    hash[:created_at] = self.created_at.iso8601
    hash[:comments] = self.comments
    return hash
  end

end

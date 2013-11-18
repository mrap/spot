class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :user, inverse_of: :posts
  belongs_to :place
  has_and_belongs_to_many :helped_users, class_name: "User", inverse_of: :helpful_posts
  has_one :post_to_place_event, dependent: :destroy

  field :description
  has_mongoid_attached_file :photo,
    default_style: :medium,
    styles: {
      medium: ['600x600>',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' },
    dependent: :destroy

  validates_presence_of :user

  after_create  :update_place_posts_count
  after_create  :create_post_to_place_event
  after_destroy :update_place_posts_count

  private

    def update_place_posts_count
      self.place.posts_count = self.place.posts.count
    end

    def create_post_to_place_event
      PostToPlaceEvent.create!(place: self.place, post: self)
    end

end

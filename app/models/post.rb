class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :user
  belongs_to :place
  has_and_belongs_to_many :helped_users, class_name: "User", inverse_of: :helpful_posts

  field :description
  has_mongoid_attached_file :photo,
    default_style: :medium,
    styles: {
      medium: ['600x600>',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' },
    dependent: :destroy

  after_create  :update_place_posts_count
  after_destroy :update_place_posts_count

  private

    def update_place_posts_count
      self.place.posts_count = self.place.posts.count
    end

end

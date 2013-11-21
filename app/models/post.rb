class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :author, class_name: "User", inverse_of: :posts
  belongs_to :place
  belongs_to :post_streak
  has_and_belongs_to_many :helped_users, class_name: "User", inverse_of: :helpful_posts
  has_one :post_reward, dependent: :destroy
  has_many :helpful_post_rewards, dependent: :destroy

  field :description
  has_mongoid_attached_file :photo,
    default_style: :medium,
    styles: {
      medium: ['600x600>',   :jpg]
    },
    convert_options: { all: '-background white -flatten +matte' },
    dependent: :destroy

  validates_presence_of :author

  after_create  :update_place, :create_post_reward
  after_destroy :update_place

  scope :recent, ->{ order_by(created_at: :desc) }

  def add_helped_user(user)
    if self.helped_users << user
      HelpfulPostReward.create!(post: self, giver: user)
    end
  end

  def remove_helped_user(user)
    if self.helped_users.delete(user)
      HelpfulPostReward.where(post: self, giver: user).first.destroy
    end
  end

  private

    def update_place
      self.place.post_changed_callback
    end

    def create_post_reward
      PostReward.create!(post: self)
    end
end

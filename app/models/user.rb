class User
  include Mongoid::Document

  has_many :posts, inverse_of: :author
  has_and_belongs_to_many :helpful_posts, class_name: "Post", inverse_of: :helped_users
  has_many :rewards_given, class_name: "Reward", inverse_of: :giver, dependent: :destroy
  has_many :rewards_received, class_name: "Reward", inverse_of: :receiver, dependent: :destroy

  field :username, type: String
  field :score,    type: Integer, default: 0

  validates_presence_of :username
  validates_uniqueness_of :username
end

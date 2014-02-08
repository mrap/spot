class User
  include Mongoid::Document

  has_many :posts, inverse_of: :author
  has_and_belongs_to_many :helpful_posts, class_name: "Post", inverse_of: :helped_users
  has_many :questions, inverse_of: :asker
  has_many :comments, inverse_of: :author, dependent: :destroy
  has_one :api_key

  field :score,    type: Integer, default: 0

  before_create :generate_api_key

  protected
    def generate_api_key
      ApiKey.create(user: self)
    end

end

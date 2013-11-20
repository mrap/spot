class PostStreak
  include Mongoid::Document

  belongs_to :place
  has_many :posts

  validate :validate_minimum_posts_count

  private

    def validate_minimum_posts_count
      errors.add(:posts, "not enough") if posts.size < MINIMUM_POSTS_PER_STREAK
    end

end

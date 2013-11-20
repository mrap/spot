class PostStreak
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :place
  has_many :posts

  field :expired,         type: Boolean,       default: false
  field :expiration_time, type: ActiveSupport::TimeWithZone,  default: lambda{ PostStreak.new_expiration_time }

  validate :validate_minimum_posts_count

  def self.new_expiration_time
    Time.zone.now.advance(seconds: POST_STREAK_EXPIRATION_INTERVAL)
  end

  private

    def validate_minimum_posts_count
      errors.add(:posts, "not enough") if posts.size < MINIMUM_POSTS_PER_STREAK
    end

end

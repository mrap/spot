class PostStreak
  include Mongoid::Document
  include Mongoid::Timestamps
  MINIMUM_POSTS_COUNT = AppConstants::POST_STREAK[:minimum_post_count]
  EXPIRATION_INTERVAL = AppConstants::POST_STREAK[:expiration_interval]

  belongs_to :place
  has_many :posts

  field :expired,         type: Boolean,       default: false
  field :expiration_time, type: ActiveSupport::TimeWithZone,  default: lambda{ PostStreak.new_expiration_time }

  validate :validate_place, :set_initial_posts, :validate_posts, on: :create

  def self.new_expiration_time
    Time.zone.now.advance(seconds: EXPIRATION_INTERVAL)
  end

  def self.streakable_place?(place)
    if place.post_streaks.where(expired: false).exists? ||
       !place_has_valid_posts_for_new_streak?(place)
      return false
    else
      return true
    end
  end

  private

    def validate_place
      errors.add(:place, "not present") unless place
    end

    def set_initial_posts
      PostStreak.place_latest_posts(place).each { |p| posts << p } unless posts?
    end

    def validate_posts
      errors.add(:posts, "not enough") if posts.size < MINIMUM_POSTS_COUNT
    end

    def self.place_has_valid_posts_for_new_streak?(place)
      return false if place.posts_count < MINIMUM_POSTS_COUNT

      latest_posts = PostStreak.place_latest_posts(place)
      latest_posts.each_with_index do |post, i|
        unless i == 0 # skip first item
          post_before  = latest_posts[i-1]
          time_between = post_before.created_at - post.created_at
          return false if time_between > EXPIRATION_INTERVAL
        end
      end
      return true
    end

    def self.place_latest_posts(place)
      place.posts.recent.limit(MINIMUM_POSTS_COUNT)
    end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post_streak do
    ignore do
      posts_count PostStreak::MINIMUM_POSTS_COUNT
    end
     posts  { FactoryGirl.create_list(:post, posts_count) }
  end
end

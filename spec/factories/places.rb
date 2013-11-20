# Read about factories at https://github.com/thoughtbot/factory_girl

MAX_COORDINATE = 179.9999999
MIN_COORDINATE = -179.9999999
def random_coordinate
  rand * (MAX_COORDINATE-MIN_COORDINATE) + MIN_COORDINATE
end

FactoryGirl.define do
  factory :place do
    sequence(:name)   { |n| "Place #{n}" }
    coordinates       { { lat: random_coordinate, long: random_coordinate } }

    trait :with_post do
      after(:create) do |place|
        create(:post, place: place)
      end
    end

    factory :place_with_post, traits: [:with_post]

    factory :place_with_posts do
      ignore do
        posts_count 2
      end
      after(:create) do |place, evaluator|
        create_list(:post, evaluator.posts_count, place: place)
      end
    end

    factory :place_with_post_streak do
      after(:create) do |place|
        create(:post_streak, place: place)
        place.post_streaks.first.posts.each do |post|
          post.place = place
        end
      end
    end
  end
end

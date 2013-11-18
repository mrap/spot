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
  end
end

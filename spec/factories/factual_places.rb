# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :factual_place, class: FactualPlace, parent: :place do
    sequence(:factual_id) { |n| "3e27025b-1025-4b9c-a8e1-97d314482bd#{n}"}

    factory :chipotle_factual_place do
      name          "Chipotle"
      factual_id    "cb236b05-1a09-421e-9493-9d022f476757"
      coordinates   {{ latitude: 37.67178, longitude: -122.464216 }}
    end

    factory :starbucks_factual_place do
      name          "Starbucks"
      factual_id    "cb236b05-1a09-421e-9493-9d022f476757"
      coordinates   {{ latitude: 37.671391, longitude: -122.463909 }}
    end
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :factual_place do
    sequence(:factual_id) { |n| "3e27025b-1025-4b9c-a8e1-97d314482bd#{n}"}
  end
end

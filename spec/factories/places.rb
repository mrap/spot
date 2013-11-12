# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place, class: Place, parent: :location do
    sequence(:name)   { |n| "Place #{n}" }
  end
end

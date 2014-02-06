# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registered_user do
    sequence(:username) { |n| "User #{n}" }
    sequence(:email)    { |n| "user#{n}@example.com" }
    password            "password"
  end
end

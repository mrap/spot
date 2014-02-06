# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest_user do
    unique_identifier { create(:unique_identifier) }
  end
end

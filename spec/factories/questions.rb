# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    asker { create(:user) }
    place { create(:place) }
  end
end

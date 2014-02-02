# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    post   { create(:post) }
    author { create(:user) }
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
    author  { create(:user) }
    place   { create(:place) }

    trait :with_photo do
      photo   File.new(Rails.root + 'spec/factories/paperclip/demo_photo.jpg')
    end

    trait :with_helped_user do
      after(:create) do |post|
        user = create(:user)
        user.helpful_posts << post
      end
    end

    factory :post_with_photo, traits: [:with_photo]
    factory :post_with_helped_user, traits: [:with_helped_user]
  end
end

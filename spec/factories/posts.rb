# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do

    trait :with_photo do
      photo   File.new(Rails.root + 'spec/factories/paperclip/demo_photo.jpg')
    end

    factory :post_with_photo, traits: [:with_photo]
  end
end

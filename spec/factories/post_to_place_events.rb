# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post_to_place_event, class: PostToPlaceEvent, parent: :event do
    place { create(:place) }
    post  { create(:post, place: place) }
  end
end

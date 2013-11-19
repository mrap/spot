# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post_reward, class: PostReward, parent: :reward do
    post  { create(:post) }
  end
end

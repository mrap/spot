# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :helpful_post_reward, class: HelpfulPostReward, parent: :reward do
    post          { create(:post) }
  end
end

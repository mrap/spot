require 'spec_helper'

describe PostStreak do
  it { should have_many :posts }

  it "should not allow post_streaks that do not have the minimum amount of posts" do
    expect{ create(:post_streak, posts_count: MINIMUM_POSTS_PER_STREAK - 1) }.to raise_error
    expect{ create(:post_streak) }.to change{ PostStreak.count }.by(1)
  end
end

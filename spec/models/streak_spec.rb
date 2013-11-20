require 'spec_helper'

describe Streak do
  it { should have_many :posts }

  it "should not allow streaks that do not have the minimum amount of posts" do
    expect{ create(:streak, posts_count: MINIMUM_POSTS_PER_STREAK - 1) }.to raise_error
    expect{ create(:streak) }.to change{ Streak.count }.by(1)
  end
end

require 'spec_helper'

describe PostStreak do

  it { should belong_to :place }
  it { should have_many :posts }
  it { should have_field :created_at }
  it { should have_field :updated_at }
  it { should have_field(:expired).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:expiration_time).of_type(ActiveSupport::TimeWithZone) }

  it "should not allow post_streaks that do not have the minimum amount of posts" do
    expect{ create(:post_streak, posts_count: MINIMUM_POSTS_PER_STREAK - 1) }.to raise_error
    expect{ create(:post_streak) }.to change{ PostStreak.count }.by(1)
  end

  # Instance Specs

  subject(:post_streak) { create(:post_streak) }
  it "should have correct expiration_time" do
    post_streak.expiration_time.round.should eq PostStreak.new_expiration_time.round
  end
end

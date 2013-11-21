require 'spec_helper'

describe PostStreak do

  it { should belong_to :place }
  it { should have_many :posts }
  it { should have_field :created_at }
  it { should have_field :updated_at }
  it { should have_field(:expired).of_type(Boolean).with_default_value_of(false) }
  it { should have_field(:expiration_time).of_type(ActiveSupport::TimeWithZone) }

  describe "PostStreak.place_streakable()?" do
    let(:streakable?)   { PostStreak.streakable_place?(place) }
    let(:place) { create(:place) }
    context "when place doesn't have enough posts" do
      let(:place) { create(:place_with_posts, posts_count: PostStreak::MINIMUM_POSTS_COUNT - 1) }
      it "should return false if place is able to create a valid post_streak" do
        streakable?.should eq false
      end
    end
    context "when place has an unexpired streak" do
      before { place.post_streaks << create(:post_streak) }
      it "should return false" do
        streakable?.should eq false
      end
    end
    context "when place's last #{PostStreak::MINIMUM_POSTS_COUNT} posts are not within the PostStreak::EXPIRATION_INTERVAL" do
      let(:place) { create(:place_with_posts, posts_count: PostStreak::MINIMUM_POSTS_COUNT - 1) }
      before      { create(:post, place: place, created_at: PostStreak.new_expiration_time.advance(seconds: 1)) }
      it "should return false" do
        streakable?.should eq false
      end
    end
  end

  # Instance Specs

  subject(:post_streak) { create(:post_streak) }

  it "should have correct expiration_time" do
    post_streak.expiration_time.round.should eq PostStreak.new_expiration_time.round
  end

  it "should not allow post_streaks that do not have the minimum amount of posts" do
    expect{ create(:post_streak, posts_count: PostStreak::MINIMUM_POSTS_COUNT - 1) }.to raise_error
  end

  it "can be created by only assigning :place with enough posts" do
    place = create(:place_with_posts, posts_count: PostStreak::MINIMUM_POSTS_COUNT)
    PostStreak.create!(place: place).should_not raise_error
  end
end

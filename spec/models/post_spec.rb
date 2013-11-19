require 'spec_helper'

describe Post do

  it { should belong_to :user }
  it { should belong_to :place }
  it { should have_one(:post_reward).with_dependent(:destroy) }
  it { should have_and_belong_to_many(:helped_users).of_type(User).as_inverse_of(:helpful_posts) }
  it { should have_field :created_at }
  it { should have_field :description }
  it { validate_presence_of :user }

  it "should have an attachment :photo", :slow do
    post = create(:post_with_photo)
    post.photo.url.should_not be_nil
  end

  context "when adding/removing a post to/from a place" do
    let(:place) { create(:place) }
    it "should update place.posts_count" do
      expect{ @post = create(:post, place: place) }.to change{ place.posts_count }.by(1)
      expect{ @post.destroy }.to change{ place.posts_count }
    end
    it "should create a post_to_place_event" do
      expect{ @post = create(:post, place: place) }.to change{ PostReward.count }.by(1)
    end
  end
end

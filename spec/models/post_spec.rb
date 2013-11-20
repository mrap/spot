require 'spec_helper'

describe Post do

  it { should belong_to :author }
  it { should belong_to :place }
  it { should belong_to :post_streak }
  it { should have_one(:post_reward).with_dependent(:destroy) }
  it { should have_many(:helpful_post_rewards).with_dependent(:destroy) }
  it { should have_and_belong_to_many(:helped_users).of_type(User).as_inverse_of(:helpful_posts) }
  it { should have_field :created_at }
  it { should have_field :description }
  it { validate_presence_of :user }

  describe "scopes" do
    describe "recent" do
      before do
        @second = create(:post, created_at: Time.now.advance(minutes: -2))
        @first  = create(:post)
      end
      it "should order properly" do
        Post.recent.to_a.should eq [@first, @second]
      end
    end
  end

  it "should have an attachment :photo", :slow do
    post = create(:post_with_photo)
    post.photo.url.should_not be_nil
  end

  context "when adding a post a place" do
    let(:place) { create(:place) }
    it "should update place.posts_count" do
      expect{ @post = create(:post, place: place) }.to change{ place.posts_count }.by(1)
      expect{ @post.destroy }.to change{ place.posts_count }
    end
    it "should create a post_reward" do
      expect{ @post = create(:post, place: place) }.to change{ PostReward.count }.by(1)
    end
  end

  describe ".add_helped_user(user)" do
    let(:user)        { create(:user) }
    let(:post)        { create(:post) }
    let(:add_user)    { post.add_helped_user(user) }
    it "should add user to helped_users" do
      expect{ add_user }.to change{ post.helped_users.count }.by(1)
    end
    it "should not allow duplicates" do
      add_user
      expect{ add_user }.not_to change{ post.helped_users.count }
    end
    it "should create a helpful_post_reward" do
      expect{ add_user }.to change{ HelpfulPostReward.count }.by(1)
    end
    it "should not allow duplicate helpful_post_reward" do
      add_user
      expect{ add_user }.not_to change{ HelpfulPostReward.count }
    end

    context "then .remove_helped_user" do
      before { add_user }
      let(:remove_user) { post.remove_helped_user(user) }

      it "should remove user to helped_users" do
        expect{ remove_user }.to change{ post.helped_users.count }.by(-1)
      end
      it "should destroy a helpful_post_reward" do
        expect{ remove_user }.to change{ HelpfulPostReward.count }.by(-1)
      end
    end
  end
end

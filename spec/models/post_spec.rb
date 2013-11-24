require 'spec_helper'

describe Post do

  it { should belong_to :author }
  it { should belong_to :place }
  it { should belong_to :post_streak }
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

  # Instance Specs

  subject(:post) { create(:post) }

  describe ":photo", :slow do
    subject(:post) { create(:post_with_photo) }
    its(:photo)    { url.should_not be_nil }
  end

  describe ".add_helped_user(user)" do
    let(:user)        { create(:user) }
    let(:add_user)    { post.add_helped_user(user) }
    it "should add user to helped_users" do
      expect{ add_user }.to change{ post.helped_users.count }.by(1)
    end
    it "should not allow duplicates" do
      add_user
      expect{ add_user }.not_to change{ post.helped_users.count }
    end
  
    context "then .remove_helped_user" do
      before { add_user }
      let(:remove_user) { post.remove_helped_user(user) }

      it "should remove user to helped_users" do
        expect{ remove_user }.to change{ post.helped_users.count }.by(-1)
      end
    end
  end
end

require 'spec_helper'

describe PostToPlaceEvent do
  it { should be_kind_of Event }
  it { should belong_to :place }
  it { should belong_to :post }
  it { should validate_presence_of :place }
  it { should validate_presence_of :post }

  context "when creating a PostToPlaceEvent" do
    subject(:event) { create(:post_to_place_event) }
    its(:initiator) { should eq event.post.user }
  end

  describe "scoring" do
    let(:user)  { create(:user) }
    let(:place) { create(:place) }
    let(:post)  { create(:post, place: place, user: user) }
    context "when post is first post of place" do
      it "should increase the user score by 50" do
        expect{ post }.to change{ user.score }.by(50)
      end
    end
    context "when post already has first post" do
      let(:place) { create(:place_with_post) }
      it "should increase the user score with a minimum of 10 points" do
        user.score.should eq 0
        post
        user.score.should >= 10
      end
      it "should increase the user score based on the last post's time" do

      end
    end
  end
end

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
    let(:first_post)  { create(:post, place: place, user: user) }
    context "when post is first post of place" do
      it "should increase the user score by 50" do
        expect{ first_post }.to change{ user.score }.by(50)
      end
    end
  end
end

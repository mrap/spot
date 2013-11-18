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

  context "when post is first post of place" do
    let(:user)  { create(:user) }
    let(:place) { create(:place) }
    let(:post)  { create(:post, place: place, user: user) }
    it "should increase the user score by 50" do
      expect{ post }.to change{ user.score }.by(50)
    end
  end

  # context "when creating a PostEvent" do
  #   before do
  #     @recently_updated_place     = create(:place)
  #     @not_recently_updated_place = create(:place)
  #     create(:post, place: @recently_updated_place, created_at: DateTime.now.advance(minutes: -1))
  #     create(:post, place: @not_recently_updated_place, created_at: DateTime.now.advance(minutes: -30))
  #   end

  #   it "score_change increases based on the time since place's last post" do
  #     post_event = create(:post_to_place_event, place: @recently_update_place, post: create(:post, place: @recently_update_place))

  #   end
  # end
end

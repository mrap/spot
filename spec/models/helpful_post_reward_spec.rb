require 'spec_helper'

describe HelpfulPostReward do
  it { should be_kind_of Reward }
  it { should belong_to :post }
  it { should validate_presence_of :post }

  context "when created" do
    let(:user)          { create(:user) }
    let(:helpful_post)  { create(:post, user: user) }
    before { helpful_post }
    subject(:reward)  { create(:helpful_post_reward, post: helpful_post) }
    it "increases the post's author's score by 2" do
      expect{ reward }.to change{ user.score }.by(2)
    end
  end
end

require 'spec_helper'

describe Reward do
  base_score = ENV['BASE_SCORE'].to_i

  it { should belong_to(:receiver).as_inverse_of(:rewards_received) }
  it { should have_field :created_at }
  it { should have_field(:base_score).of_type(Integer).with_default_value_of(base_score) }
  it { should have_field(:score_change).of_type(Integer).with_default_value_of(0) }
  it { should have_field(:score_bonus).of_type(Integer).with_default_value_of(0) }

  context "when creating an reward" do
    let(:user)  { create(:user) }
    it "should alter the receiver's score" do
      expect{ create(:reward, score_change: 1, receiver: user) }.to change{ user.score }.by(1)
    end
    it "should add bonus_score" do
      expect{ create(:reward, score_change: 1, score_bonus: 1, receiver: user) }.to change{ user.score }.by(2)
    end
  end
end

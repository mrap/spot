require 'spec_helper'

describe Event do
  base_score = ENV['BASE_SCORE'].to_i

  it { should belong_to(:initiator).as_inverse_of(:events) }
  it { should have_field :created_at }
  it { should have_field(:base_score).of_type(Integer).with_default_value_of(base_score) }
  it { should have_field(:score_change).of_type(Integer).with_default_value_of(0) }
  it { should have_field(:score_bonus).of_type(Integer).with_default_value_of(0) }
  it { should have_field(:description).of_type(String) }

  context "when creating an event" do
    let(:user)  { create(:user) }
    let(:event) { create(:event, initiator: user) }
    it "should alter the initiator's score" do
      expect{ create(:event, initiator: user) }.to change{ user.score }.by(base_score)
    end
    it "should add bonus_score" do
      expect{ create(:event, initiator: user, score_bonus: 1) }.to change{ user.score }.by(base_score + 1)
    end
    it "automatically adds default description" do
      event.description.should match "Event created on #{event.created_at}, initiated by #{user}"
    end
  end
end

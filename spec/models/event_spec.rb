require 'spec_helper'

describe Event do
  it { should belong_to :initiator }
  it { should have_field :created_at }
  it { should have_field(:score_change).of_type(Integer).with_default_value_of(0) }
  it { should have_field(:description).of_type(String) }
  it { should validate_presence_of :initiator }

  context "when creating an event" do
    let(:user)  { create(:user) }
    let(:event) { create(:event, initiator: user) }
    it "should alter the initiator's score" do
      expect{ create(:event, initiator: user, score_change: 1) }.to change{ user.score }.by(1)
      expect{ create(:event, initiator: user, score_change: -1) }.to change{ user.score }.by(-1)
    end
    it "automatically adds default description" do
      event.description.should match "Event created on #{event.created_at}, initiated by #{user}"
    end
  end
end

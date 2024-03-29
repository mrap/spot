require 'spec_helper'

describe ApiKey do
  it { should belong_to :user }
  it { should have_field :token }
  it { should have_field(:expiration_date).of_type(DateTime) }
  it { should validate_presence_of :token }
  it { should validate_uniqueness_of :token }
  it { should validate_presence_of :expiration_date }

  subject(:api_key) { create(:api_key) }

  its(:token) { should_not be_nil }

  describe "finding a user with token" do
    context "when token belongs to a user" do
      it "should return the user" do
        user = create(:user)
        ApiKey.find_user_with_token(user.api_key.token).should eq user
      end
    end
    context "when no user has that token" do
      it "should return nil" do
        ApiKey.find_user_with_token("a-bad-token").should eq nil
      end
    end
  end

  describe "expiration" do
    it "has a correct expiration date" do
      time_until_expiration = (Time.now - api_key.expiration_date) * -1
      time_until_expiration.should be_close(ApiKey::EXPIRATION_INTERVAL, 1)
    end
    describe ".expired?" do
      context "when expiration date has not passed" do
        its(:expired?) { should be_false }
      end
      context "when expired" do
        before { api_key.expiration_date = Time.now }
        its(:expired?) { should be_true }
      end
    end
  end
end

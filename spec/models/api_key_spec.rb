require 'spec_helper'

describe ApiKey do
  it { should belong_to :user }
  it { should have_field :token }
  it { should have_field(:expiration_date).of_type(DateTime) }

  subject(:api_key) { create(:api_key) }

  its(:token) { should_not be_nil }

  describe "finding a user with token" do
    subject(:found_user) { ApiKey.find_user_with_token(api_key.token) }
    context "when a user is found" do
      before do
        @user = create(:user)
        @user.api_key = api_key
      end
      it { should eq @user }
    end
    context "when no user has that token" do
      it { should be nil }
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

require 'spec_helper'

describe ApiKey do
  it { should belong_to :user }
  it { should have_field :token }

  subject(:api_key) { create(:api_key) }

  describe "instance of ApiKey" do
    its(:token) { should_not be_nil }
  end

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
end

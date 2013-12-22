require 'spec_helper'

describe "existing user requesting a fresh access token" do

  before do
    @email = "user@example.com"
    @password = "password"
    @user = create(:user, email: @email, password: @password)
  end

  context "when requesting with valid credentials" do
    before do
      post '/tokens', nil, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(@email,@password)
    end
    it "should return the new token" do
      json['token'].should_not be_nil
      json['expiration'].should_not be_nil
    end
  end
end

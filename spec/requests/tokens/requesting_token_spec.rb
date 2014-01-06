require 'spec_helper'

describe "existing user requesting a fresh access token" do

  let(:email)    { "user@example.com" }
  let(:password) { "password" }
  let(:user)     { create(:user, email: email, password: password) }

  context "when requesting with valid credentials" do
    before do
      user
      post '/tokens', nil, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(email,password)
    end
    it "should return the new token" do
      @user = User.where(email: email).first
      json['token'].should eq @user.api_key.token
      json['expiration'].should eq @user.api_key.expiration_date.to_s
    end
  end
end

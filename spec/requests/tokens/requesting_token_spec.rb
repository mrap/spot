require 'spec_helper'

describe "registered user requesting a fresh access token" do

  let(:email)             { "user@example.com" }
  let(:password)          { "password" }
  let(:registered_user)   { create(:registered_user, email: email, password: password) }

  context "when requesting with valid credentials" do
    before do
      registered_user
      post 'api/v1/tokens', nil, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(email,password)
    end
    it "should return the new token" do
      @user = User.where(email: email).first
      json['data']['token'].should eq @user.api_key.token
      json['data']['expiration'].should eq @user.api_key.expiration_date.to_s
    end
  end
end

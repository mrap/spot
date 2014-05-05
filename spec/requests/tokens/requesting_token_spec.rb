require 'spec_helper'

describe "registered user requesting a fresh access token" do

  let(:email)             { "user@example.com" }
  let(:password)          { "password" }
  let(:registered_user)   { create(:registered_user, email: email, password: password) }

  context "when requesting with valid credentials" do
    before do
      @original_token = registered_user.api_key.token
      @original_expiration_date = registered_user.api_key.expiration_date
      post 'api/v1/tokens', nil, 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(email,password)
    end
    it "should return the new token" do
      json['data']['token'].should_not eq @original_token
      json['data']['expiration'].to_time.to_i.should eq @original_expiration_date.to_i
    end
  end
end

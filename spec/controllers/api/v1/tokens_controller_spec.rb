require 'spec_helper'

describe Api::V1::TokensController do
  before do
    @email = "user@example.com"
    @password = "password"
    @user = FactoryGirl.create(:user, email: @email, password: @password)
  end

  describe "POST #new" do

    context "with valid user credentials" do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(@email,@password)
      end
      it "should be successful" do
        post :create
        response.should be_success
      end
    end

    context "without any credentials" do
      it "should be a bad request" do
        post :create
        response.status.should eq 401
      end
    end

    context "with invalid user credentials" do
      before do
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(@email,"bad password")
      end
      it "should be an unauthorized request" do
        post :create
        response.status.should eq 401
      end
    end

  end
end

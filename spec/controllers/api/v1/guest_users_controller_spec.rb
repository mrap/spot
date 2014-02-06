require 'spec_helper'

describe Api::V1::GuestUsersController do
  describe "POST #create" do
    it "should be successful" do
      post :create
      response.status.should eq 201
    end

    it "should create a new guest user" do
      expect{ post :create }.to change{ GuestUser.count }.by(1)
    end
  end
end

require 'spec_helper'

describe Api::V1::RegistrationsController do
  describe "POST #create" do

    context "with valid parameters for a new user" do
      it "should return a created status code (201)" do
        post :create, user: { email: "mike@mrap.me", username: "mrap", password: "password" }
        response.status.should eq 201
      end
    end

    context "with invalid parameters" do
      it "should return a unprocessable status code (422)" do
        post :create
        response.status.should eq 422
      end
    end

  end
end

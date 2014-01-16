require 'spec_helper'

describe "Creating a new user" do

  context "with valid parameters for a new user" do
    before do 
      post 'api/v1/users',
        user: { email: "mike@mrap.me", username: "mrap", password: "password" }
    end
    let(:new_user) { User.where(username: "mrap").first }

    it "should return the new user's token" do
      json['data']['token'].should eq new_user.api_key.token
    end

    it "should return the token expiration date" do
      json['data']['expiration'].should eq new_user.api_key.expiration_date.to_s
    end
  end

  context "with invalid parameters" do
    before do
      post 'api/v1/users'
    end

    it "should return an error" do
      json['meta']['errors'].should_not be_nil
    end
  end

end

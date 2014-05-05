require 'spec_helper'

describe "Creating a new registered user" do

  context "with valid parameters for a new registered user" do
    before do 
      post 'api/v1/registered_users',
        registered_user: { email: "mike@mrap.me", username: "mrap", password: "password" }
    end
    let(:new_registered_user) { RegisteredUser.where(username: "mrap").first }

    it "should return the new user's token" do
      json['data']['token'].should eq new_registered_user.api_key.token
    end

    it "should return the token expiration date" do
      json['data']['expiration'].to_time.to_i.should eq new_registered_user.api_key.expiration_date.to_i
    end
  end

  context "with invalid parameters" do
    before do
      post 'api/v1/registered_users'
    end

    it "should return an error" do
      json['meta']['errors'].should_not be_nil
    end
  end

end

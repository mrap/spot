require 'spec_helper'

describe "creating a guest user" do
  before { post 'api/v1/guest_users' }
  let(:new_guest_user) { GuestUser.last }

  it "should return the new guest user's token" do
    json['data']['token'].should eq new_guest_user.api_key.token
    json['data']['server_uid'].should eq new_guest_user.unique_identifier.server_uid
  end
end

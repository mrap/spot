require 'spec_helper'


describe "Requesting for a place JSON reference" do

  context "with a valid place_id" do
    let(:place) { create(:place) }
    before do
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end

    it "should have an id" do
      json['data']['id'].should eq place.id.to_s
      json['data'].should_not have_key :_id
    end

    it "should have a name" do
      json['data']['name'].should eq place.name
    end

    it "should have latitude and longitude but not `coordinates`" do
      json['data']['longitude'].should eq place.longitude
      json['data']['latitude'].should eq place.latitude
      json['data'].should_not have_key :coordinates
    end

    it "should have address info" do
      json['data']['address'].should eq place.address
    end

  end
end

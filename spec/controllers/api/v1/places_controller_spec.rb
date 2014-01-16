require 'spec_helper'

describe Api::V1::PlacesController do
  let(:coordinates) { build(:chipotle_factual_place).coordinates }
  let(:latitude)    { coordinates.latitude }
  let(:longitude)    { coordinates.longitude }

  before { set_token_auth_with_user }

  describe "GET #show" do
    let(:place) { create(:place) }

    context "with a valid place_id" do
      it "is successful" do
        get :show, id: place.id
        response.should be_successful
        assigns(:place).should eq place
      end
    end

    context "with an invalid place_id" do
      it "should return a not found status code (404)" do
        get :show, id: "bad-request"
        response.status.should eq 404
      end
    end
  end

  describe "GET #search" do
    # Required url params: [:longitude, :latitude]
    # Optional url params: [:radius, :search_terms]
    context "with latitude and longitude params", :vcr do
      it "is successful" do
        get :search, latitude: latitude, longitude: longitude
        expect(response).to be_success
      end
    end
    context "when not :latitude and :longitude not provided ", :vcr do
      it "is unsuccessful as a bad request" do
        get :search
        response.status.should eq 400
      end
    end
  end

end

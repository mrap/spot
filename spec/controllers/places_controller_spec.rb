require 'spec_helper'

describe PlacesController do
  let(:coordinates) { build(:chipotle_factual_place).coordinates }
  let(:latitude)    { coordinates.latitude }
  let(:longitude)    { coordinates.longitude }
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

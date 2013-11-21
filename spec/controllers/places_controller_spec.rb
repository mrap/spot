require 'spec_helper'

describe PlacesController do
  let(:coordinates) { build(:chipotle_factual_place).coordinates }
  let(:latitude)    { coordinates.latitude }
  let(:longitude)    { coordinates.longitude }
  describe "GET #nearby", :vcr => { record: :new_episodes } do
    # Required url params: [:longitude, :latitude]
    # Optional url params: [:radius, :search_terms]
    context "with latitude and longitude params" do
      it "is successful" do
        get :nearby, latitude: latitude, longitude: longitude
        expect(response).to be_success
      end
    end
    context "when not :latitude and :longitude not provided " do
      it "is successful" do
        get :nearby
        response.status.should eq 400
      end
    end
  end
end

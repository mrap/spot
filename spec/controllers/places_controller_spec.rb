require 'spec_helper'

describe PlacesController do
  describe "GET #nearby", :vcr do
    it "is successful" do
      get :nearby, latitude: 20 ,longitude: 20
      expect(response).to be_success
    end
    context "when radius in url params" do
      it "is successful" do
        get :nearby, latitude: 20 ,longitude: 20, radius: 500
        expect(response).to be_success
      end
    end
  end

  describe "GET #search_nearby", :vcr do
    it "is successful" do
      get :search_nearby
      expect(response).to be_success
    end
  end

  describe "GET #search_in_locality", :vcr do
    it "is successful" do
      get :search_in_locality, locality: "San Francisco"
      expect(response).to be_success
    end
  end

  # TODO: set up VCR for test requests
  # describe "GET #search_in_locality" do
  #   context "when no :locality in request" do
  #       it "is successful" do
  #       get :search_in_locality
  #       expect(response).to eq 400
  #     end
  #   end
  # end

end

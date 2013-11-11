require 'spec_helper'

describe PlacesController do
  describe "GET #nearby" do
    it "is successful" do
      get :search_nearby
      expect(response).to be_success
    end
  end

  describe "GET #search_nearby" do
    it "is successful" do
      get :search_nearby
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

require 'spec_helper'

describe "fetching places from location api" do

  describe "search nearby", :vcr do
    let(:url_params) { { search_terms: "never too latte", latitude: 37.6247791, longitude: -122.4113215 } }
    let(:request) { get '/places/search_nearby', url_params, nil }
    it "should be successful" do
      request
      response.status.should eq 200
    end
  end

  describe "nearby", :vcr do
    let(:url_params) { { latitude: 37.6247791, longitude: -122.4113215 } }
    let(:request) { get '/places/nearby', url_params, nil }
    it "should be successful" do
      request
      response.status.should eq 200
    end
  end

  describe "search_in_locality", :vcr do
    let(:url_params) { { search_terms: "never too latte", locality: "San Bruno" } }
    let(:request) { get '/places/search_in_locality', url_params, nil }
    it "should be successful" do
      request
      response.status.should eq 200
    end
  end

end

require 'spec_helper'

describe "fetching places from location api" do

  describe "search nearby" do
    let(:url_params) { { search_terms: "never too latte", latitude: 37.6247791, longitude: -122.4113215 } }
    let(:request) { get '/places/search_nearby', url_params, nil }
    it "should be successful" do
      request
      response.status.should eq 200
    end
  end

end

require 'spec_helper'

describe GooglePlace do
  it { should have_field :google_id }
  it { should validate_presence_of :google_id }
  it { should validate_uniqueness_of :google_id }

  describe "creating from a api ref" do
    let(:chipotle_coordinates) { Coordinates.new_with_lat_long(37.6717, -122.464216) }
    let(:api_results)          { GooglePlacesClient.spots(chipotle_coordinates.latitude, chipotle_coordinates.longitude) }
    let(:api_ref)              { api_results.first }
    subject(:place)            { GooglePlace.create_from_api_ref api_ref }

    its(:name)        { should_not be_nil }
    its(:address)     { should_not be_nil }
    its(:coordinates) { should_not be_nil }
  end

  describe "#places_near_coordinates" do
    let(:chipotle_coordinates)        { Coordinates.new_with_lat_long(37.6717, -122.464216) }
    subject(:places_with_coordinates) { GooglePlace.places_near_coordinates(chipotle_coordinates) }

    it { should have_at_least(1).items }

    it "should create the places in the database" do
      places = places_with_coordinates
      GooglePlace.count.should eq places.count
    end
  end
end

require 'spec_helper'

describe FoursquarePlace do
  it { should have_field :foursquare_id }
  it { should validate_presence_of :foursquare_id }
  it { should validate_uniqueness_of :foursquare_id }

  describe "#places_near_coordinates" do
    let(:chipotle_coordinates)        { Coordinates.new_with_lat_long(37.6717, -122.464216) }
    subject(:places_with_coordinates) { FoursquarePlace.places_near_coordinates(chipotle_coordinates) }

    it { should have_at_least(1).items }

    it "should create the places in the database" do
      places = places_with_coordinates
      FoursquarePlace.count.should eq places.count
    end

    describe "a saved FoursquarePlace instance" do
      subject(:place) { places_with_coordinates.first }

      its(:name)              { should_not be_nil }
      its(:address)           { should_not be_nil }
      its(:coordinates)       { should_not be_nil }
    end

    context "with :query option" do
      let(:places)    { FoursquarePlace.places_near_coordinates(chipotle_coordinates, query: 'Chipotle') }
      subject(:first) { places.first }

      its(:name) { should include 'Chipotle' }
    end
  end
end

require 'spec_helper'

describe GooglePlace do

  describe "#places_with_coordinates" do
    let(:chipotle_coordinates) { Coordinates.new_with_lat_long(37.6717, -122.464216) }

    it "should return an array of places" do
      result = GooglePlace.places_with_coordinates(chipotle_coordinates)
      result.should have_at_least(1).items
    end
  end

end

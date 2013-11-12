require 'spec_helper'

describe Place do

  # Relations
  it { should have_many :posts }

  # Fields
  it { should have_fields :name,
                          :address,
                          :address_extended,
                          :locality,
                          :region,
                          :country,
                          :postcode,
                          :longitude,
                          :latitude,
                          :neighborhood }

  # Validations
  it { should validate_presence_of :name }

  describe "calculating distances" do
    let(:my_coordinates) { {latitude: "37.781127", longitude: "-122.417102" } } # City Hall
    let(:ball_park) { create(:place, latitude: "37.778949", longitude: "-122.389329") }

    it ".meters_from_coordinates()" do
      ball_park.meters_from_coordinates(my_coordinates).should be < 2500 # actual is about 2458.55 meters
    end

    it ".miles_from_coordinates()" do
      ball_park.miles_from_coordinates(my_coordinates).should be < 1.6 # actual is about 1.527 miles
    end
  end
end

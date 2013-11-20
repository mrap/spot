require 'spec_helper'

describe Place do
  # Relations
  it { should have_many :posts }
  it { should have_many :post_streaks }

  # Fields
  it { should have_fields :name,
                          :address,
                          :address_extended,
                          :locality,
                          :region,
                          :country,
                          :postcode,
                          :neighborhood,
                          :coordinates }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :coordinates }

  subject(:place) { build(:place) }

  describe "coordinates helper methods" do
    its(:longitude) { should eq place.coordinates.to_hsh[:x] }
    its(:latitude) { should eq place.coordinates.to_hsh[:y] }
  end

  let(:coordinates) { Coordinates.new(-122.417102, 37.781127)  }

  describe "nearby_coordinates" do
    before do
      @nearby_place = create(:place, coordinates: coordinates)
      # far place is definitely greater than 1000 meters away
      @far_place = create(:place, coordinates: { latitude: coordinates.longitude, longitude: coordinates.latitude })
    end
    context "with :radius" do
      subject(:results) { Place.nearby_coordinates(coordinates, radius: 1000).to_a }
      it { should include @nearby_place }
      it { should_not include @far_place }
    end
    context "without :radius" do
      subject(:results) { Place.nearby_coordinates(coordinates).to_a }
      it { should include @far_place }
    end
  end

  describe ".distance_to_coordinates" do
    let(:ball_park) { create(:place, coordinates: {latitude: "37.778949", longitude: "-122.389329"}) }
    subject { ball_park.distance_to_coordinates(coordinates) }

    it { should be_close 2500, 100 } # meters
    it { should be_kind_of Float }
  end

  describe "full text search" do
    before do
      @chipotle  = create(:chipotle_factual_place)
      @starbucks = create(:starbucks_factual_place)
    end
  end

end

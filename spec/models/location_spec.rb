require 'spec_helper'

describe Location do
  subject(:location) { build(:location) }

  it { should have_field(:coordinates).with_default_value_of(nil) }
  it { should validate_presence_of :coordinates }

  describe "coordinates helper methods" do
    its(:longitude) { should eq location.coordinates.to_hsh[:x] }
    its(:latitude) { should eq location.coordinates.to_hsh[:y] }
  end

  describe "finding nearby locations" do
     before do
      @my_location = build(:location, coordinates: { latitude: 37.781127, longitude: -122.417102 })
      @nearby_location = create(:location, coordinates: { latitude: 37.781128, longitude: -122.417103 })
      @far_location = create(:location, coordinates: { latitude: -37.781128, longitude: 122.417103 })
    end

    describe ".nearby_with_distance(options)" do
      it "using meters" do
        results = @my_location.nearby_within_distance_with_limit(1000).to_a
        results.should include @nearby_location
        results.should_not include @far_location
      end
      it "with :limit option" do
        @nearby_location2 = create(:location, coordinates: { latitude: 37.781128, longitude: -122.417103 })
        results = @my_location.nearby_within_distance_with_limit(1000, 1).to_a
        results.count.should eq 1
      end
    end

    describe ".nearby" do
      it "should return locations closest to furthest" do
        locations_near_me = @my_location.nearby.to_a
        locations_near_me.first.should eq @nearby_location
        locations_near_me.last.should eq @far_location
      end
    end
  end

  describe ".distance_to(location)" do
    let(:my_coordinates) { build(:location, coordinates: {latitude: "37.781127", longitude: "-122.417102" }) } # City Hall
    let(:ball_park) { create(:location, coordinates: {latitude: "37.778949", longitude: "-122.389329"}) }
    subject { ball_park.distance_to(my_coordinates) }

    it { should be_close 2500, 100 } # meters
    it { should be_kind_of Float }
  end
end

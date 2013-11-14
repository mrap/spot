require 'spec_helper'

describe Location do

  it { should have_field(:coordinates).with_default_value_of(nil) }
  it { should validate_presence_of :coordinates }

  describe "finding nearby locations" do
     before do
      @my_location = build(:location, coordinates: { latitude: 37.781127, longitude: -122.417102 })
      @nearby_location = create(:location, coordinates: { latitude: 37.781128, longitude: -122.417103 })
      @far_location = create(:location, coordinates: { latitude: -37.781128, longitude: 122.417103 })
    end

    describe ".nearby_with_distance(options)" do
      it "using miles" do
        results = @my_location.nearby_with_distance(miles: 1).to_a
        results.should include @nearby_location
        results.should_not include @far_location
      end
      it "using kilometers" do
        results = @my_location.nearby_with_distance(kilometers: 1).to_a
        results.should include @nearby_location
        results.should_not include @far_location
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

  describe "calculating distances" do
    let(:my_coordinates) { build(:location, coordinates: {latitude: "37.781127", longitude: "-122.417102" }) } # City Hall
    let(:ball_park) { create(:location, coordinates: {latitude: "37.778949", longitude: "-122.389329"}) }

    describe ".distance_to()" do
      it "return in miles (default)" do
        ball_park.distance_to(my_coordinates).should be_close 1.56, 0.1
        ball_park.distance_to(my_coordinates, miles: true).should be_close 1.56, 0.1
      end

      it "return in kilometers" do
        ball_park.distance_to(my_coordinates, kilometers: true).should be_close 2.5, 0.1
      end
    end
  end
end

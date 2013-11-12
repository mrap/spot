require 'spec_helper'

describe Location do
  it { should have_fields :coordinates, :created_at }
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
  end
end

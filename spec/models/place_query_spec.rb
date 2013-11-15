require 'spec_helper'

describe PlaceQuery do
  subject(:place_query) { build(:place_query) }

  it { should have_field(:results).with_default_value_of(nil) }
  its(:factual_query) { should_not be_nil }

  describe "querying the factual api and FactualPlaces in database" do
    let(:my_coordinates) { build(:chipotle_factual_place).coordinates }
    before do
      @starbucks = create(:starbucks_factual_place)
    end

    describe ".places_near_coordinates_within_radius", :vcr do
      subject(:results) do
        place_query.places_near_coordinates_within_radius(my_coordinates, 1000)
        place_query.results
      end
      it "should include starbucks" do
        results.should include @starbucks
      end
      it "should have other results from the factual_api" do
        results.count.should > 1
      end
    end
  end
end

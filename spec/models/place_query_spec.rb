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

    describe ".search_nearby_coordinates", :vcr do
      subject(:results) do
        place_query.search_nearby_coordinates(my_coordinates, radius: 1000)
        place_query.results
      end
      it "should include starbucks" do
        results.should include @starbucks
      end
      it "should have other results from the factual_api" do
        results.count.should > 1
      end
    end

    # describe ".search_places_near_coordinates_within_radius" do
    #   subject(:results) do
    #     place_query.search_places_near_coordinates_within_radius("chipotle", my_coordinates, 1000)
    #     place_query.results
    #   end
    #   it "should include starbucks" do
    #     results.should_not include @starbucks
    #   end
    #   it "should include Chipotle place ref from factual api" do
    #     api_ref = results.first
    #     api_ref.name.should match "Chipotle"
    #     FactualPlace.where(factual_id: api_ref.factual_id).should_not exist
    #   end
    # end
  end
end

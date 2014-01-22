require 'spec_helper'

describe PlaceQuery do
  subject(:place_query) { build(:place_query) }

  describe "querying the factual api and FactualPlaces in database" do
    let(:my_coordinates) { build(:chipotle_factual_place).coordinates }
    before do
      @starbucks = create(:starbucks_factual_place)
    end

    describe ".search_nearby_coordinates" do
      context "with only :radius option", :vcr do
        subject(:results) do
          place_query.search_nearby_coordinates(my_coordinates, radius: 10000)
        end
        it "should include starbucks" do
          results.should include @starbucks
        end
        it "should have other results from the factual_api" do
          results.count.should > 1
        end
        it "should save all factual results to the database as FactualPlaces" do
          expect{ results }.to change{ FactualPlace.count }
        end
      end

      context "with :search_text option", :vcr do
        context "when 'Chipotle' already in the database" do
          before { @chipotle = create(:chipotle_factual_place) }
          subject(:results) do
            place_query.search_nearby_coordinates(my_coordinates, search_terms: "chipotle", radius: 10000)
          end
          it "should have other results from the factual_api" do
            results.count.should > 1
          end
          it "should return the Chipotle location" do
            results.first.should eq @chipotle
          end
        end
      end
    end
  end
end

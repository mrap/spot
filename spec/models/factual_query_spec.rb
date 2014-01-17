require 'spec_helper'

describe FactualQuery do
  subject(:factual_query) { build(:factual_query) }

  it { should_not be_nil }

  describe ".nearby_coordinates", :vcr => { record: :new_episodes } do
    let(:colma_coordinates) { build(:chipotle_factual_place).coordinates }
    subject(:results) do
      factual_query.nearby_coordinates(colma_coordinates, radius: 10)
      factual_query.results
    end

    it "should return a Colma location" do
      results.first['locality'].should match "Colma"
    end

    context "with :search_terms option" do
      subject(:results) do
        factual_query.nearby_coordinates(colma_coordinates, search_terms: "chipotle", radius: 300)
        factual_query.results
      end

      it "should return the chipotle from the factual api" do
        results.first['name'].should match "Chipotle"
      end
    end
  end

  describe ".search_places_in_locality", :vcr do
    subject(:first_result) do
      factual_query.search_places_in_locality("Chipotle", "Colma")
      factual_query.results.first
    end

    it "should return a list that includes the Colma Chipotle" do
      first_result['locality'].should match "Colma"
      first_result['name'].should match "Chipotle"
    end
  end
end

require 'spec_helper'

describe FactualQuery do
  subject(:factual_query) { build(:factual_query) }

  it { should_not be_nil }

  describe ".get_places_nearby", :vcr do
    let(:colma_coordinates) { build(:chipotle_factual_place).coordinates }
    subject(:results) do
      factual_query.get_places_nearby(coordinates: colma_coordinates)
      factual_query.results
    end

    it "should return a Colma location" do
      results.first['locality'].should match "Colma"
    end
  end

  describe ".search_in_locality", :vcr do
    subject(:first_result) do
      factual_query.search_in_locality(search_terms: "Chipotle", locality: "Colma")
      factual_query.results.first
    end

    it "should return a list that includes the Colma Chipotle" do
      first_result['locality'].should match "Colma"
      first_result['name'].should match "Chipotle"
    end
  end

  describe ".search_places_nearby", :vcr do
    let(:colma_coordinates) { build(:chipotle_factual_place).coordinates }
    subject(:first_result) do
      factual_query.search_places_nearby(search_terms: "Chipotle", coordinates: colma_coordinates)
      factual_query.results.first
    end

    it "should return a list that includes the Colma Chipotle" do
      first_result['locality'].should match "Colma"
      first_result['name'].should match "Chipotle"
    end
  end
end

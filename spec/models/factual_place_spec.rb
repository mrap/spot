require 'spec_helper'

describe FactualPlace do
  it { should be_kind_of(Place) }

  # Fields
  it { should have_fields :factual_id,
                          :category_labels,
                          :hours,
                          :tel }

  # Validations
  it { should validate_presence_of :factual_id }
  it { should validate_uniqueness_of :factual_id }

  describe "creating factual api references", :vcr do
    let(:api_ref) do
      factual_query = FactualQuery.new
      factual_query.search_places_in_locality("Chipotle", "Colma")
      factual_query.results.first
    end

    subject(:saved_factual_place) do
      FactualPlace.create_from_api_ref(api_ref)
    end

    it "should have correct coordinates" do
      saved_factual_place.coordinates.longitude.should eq api_ref['longitude']
      saved_factual_place.coordinates.latitude.should eq api_ref['latitude']
    end

    it "should have a :factual_id" do
      saved_factual_place.factual_id.should match api_ref['factual_id']
    end
  end

  describe "build factual api references", :vcr do
    let(:api_ref) do
      factual_query = FactualQuery.new
      factual_query.search_places_in_locality("Chipotle", "Colma")
      factual_query.results.first
    end

    subject(:new_factual_place) do
      FactualPlace.build_from_api_ref(api_ref)
    end

    it "should have correct coordinates" do
      new_factual_place.coordinates.longitude.should eq api_ref['longitude']
      new_factual_place.coordinates.latitude.should eq api_ref['latitude']
    end

    it "should have a :factual_id" do
      new_factual_place.factual_id.should match api_ref['factual_id']
    end
  end
end

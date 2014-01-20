require 'spec_helper'


describe "Requesting for a place JSON reference" do

  context "with a valid place_id" do
    let(:place) { create(:place) }
    before do
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end

    let(:data) { json['data'] }

    it "should have an id" do
      data['id'].should eq place.id.to_s
      data.should_not have_key :_id
    end

    it "should have a name" do
      data['name'].should eq place.name
    end

    it "should have latitude and longitude but not `coordinates`" do
      data['longitude'].should eq place.longitude
      data['latitude'].should eq place.latitude
      data.should_not have_key 'coordinates'
    end

    it "should have address info" do
      data['address'].should eq place.address
    end

    it "should not have _keywords (from mongoid full text search)" do
      data.should_not have_key "_keywords"
    end
  end

  context "when a place has posts" do
    let(:place) { create(:place_with_posts, posts_count: 2) }
    before do
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end

    subject(:posts) { json['data']['posts'] }

    it "should have posts" do
      posts.count.should eq place.posts.count
    end

    it "should have a basic author_id" do
      posts.first['author_id'].should eq place.posts.first.author.id.to_s
    end

    it "should have a basic place_id" do
      posts.first['place_id'].should eq place.id.to_s
    end
  end

  context "when a place is a factual place" do
    let(:place) { create(:factual_place) }
    before do
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end

    it "should not return a factual_id" do
      json['data'].should_not have_key 'factual_id'
    end

    it "should not return category_labels" do
      json['data'].should_not have_key "category_labels"
    end
  end

end

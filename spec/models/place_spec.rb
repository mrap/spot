require 'spec_helper'

describe Place do
  # Relations
  it { should have_many :posts }
  it { should have_many :questions }

  # Fields
  it { should have_fields :name,
                          :address,
                          :address_extended,
                          :locality,
                          :region,
                          :country,
                          :postcode,
                          :neighborhood,
                          :coordinates }

  # Validations
  it { should validate_presence_of :name }
  it { should validate_presence_of :coordinates }

  # Instance Specs

  subject(:place) { build(:place) }

  describe "coordinates helper methods" do
    its(:longitude) { should eq place.coordinates.to_hsh[:x] }
    its(:latitude) { should eq place.coordinates.to_hsh[:y] }
  end

  let(:coordinates) { Coordinates.new(-122.417102, 37.781127)  }

  describe "nearby_coordinates" do
    before do
      @nearby_place = create(:place, coordinates: coordinates)
      # far place is definitely greater than 1000 meters away
      @far_place = create(:place, coordinates: { latitude: coordinates.longitude, longitude: coordinates.latitude })
    end
    context "with :radius" do
      subject(:results) { Place.nearby_coordinates(coordinates, radius: 1000).to_a }
      it { should include @nearby_place }
      it { should_not include @far_place }
    end
    context "without :radius" do
      subject(:results) { Place.nearby_coordinates(coordinates).to_a }
      it { should include @far_place }
    end
  end

  describe ".distance_to_coordinates" do
    let(:ball_park) { create(:place, coordinates: {latitude: "37.778949", longitude: "-122.389329"}) }
    subject { ball_park.distance_to_coordinates(coordinates) }

    it { should be_close 2500, 100 } # meters
    it { should be_kind_of Float }
  end

  describe "full text search" do
    before do
      @chipotle  = create(:chipotle_factual_place)
      @starbucks = create(:starbucks_factual_place)
    end
  end

  describe "posts" do
    let(:place) { create(:place) }
    let(:post) { create(:post, place: place) }
    context "when adding a post" do
      it "should increment :posts_count" do
        expect{post}.to change{ place.posts_count }.by(1)
      end
      it "should add post's author to current users" do
        post
        place.current_users.should include post.author
      end
    end
    context "when removing or deleting a post" do
      before { post }
      it "should decrement :posts_count" do
        expect{ post.destroy }.to change{ place.posts_count }.by(-1)
      end
    end
  end

  describe "current users" do
    let(:place) { create(:place) }
    let(:user)  { build(:user) }
    it "can add a user to current users" do
      place.add_current_user(user)
      place.current_users.should include user
    end
    it "can remove a user from current users" do
      place.add_current_user(user)
      place.remove_current_user(user)
      place.current_users.should_not include user
    end
  end
end

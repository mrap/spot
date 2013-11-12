require 'spec_helper'

describe Place do
  it { should be_kind_of(Location)}

  # Relations
  it { should have_many :posts }

  # Fields
  it { should have_fields :name,
                          :address,
                          :address_extended,
                          :locality,
                          :region,
                          :country,
                          :postcode,
                          :neighborhood }

  # Validations
  it { should validate_presence_of :name }

  describe "sorting" do
    describe ".most_posts" do
      before do
        @first  = create(:place, posts_count: 3)
        @second = create(:place, posts_count: 2)
        @third  = create(:place, posts_count: 1)
      end

      it "should sort by most posts first" do
        results = Place.most_posts.to_a
        results.should eq [@first, @second, @third]
      end
    end
  end

end

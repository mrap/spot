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

    it "should not have created_at or updated_at" do
      data.should_not have_key "created_at"
      data.should_not have_key "updated_at"
    end

    context "when it's a FoursquarePlace" do
      let(:place) { create(:foursquare_place_chipotle) }

      it "should have a foursquare id" do
        data.should have_key 'foursquare_id'
      end
    end
  end

  context "when a place has posts" do
    let(:place) { create(:place_with_post) }
    before do
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end

    subject(:posts_json) { json['data']['posts'] }

    it "should have posts" do
      posts_json.count.should eq place.posts.count
    end

    describe "post JSON" do
      let(:post_json) { posts_json.first }
      let(:post) { place.posts.last }

      it "should have a basic author_id" do
        post_json['author_id'].should eq post.author.id.to_s
      end

      it "should have a basic place_id" do
        post_json['place_id'].should eq place.id.to_s
      end

      it "should have created at date" do
        post_json['created_at'].should eq post.created_at.iso8601
      end

      it "should have the author's name" do
        post_json['author_username'].should eq post.author.username
      end
    end
  end

  context "when a post has a photo", slow: true do
    let(:place) { create(:place) }
    before do
      @post_with_photo = create(:post_with_photo, place: place)
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end
    subject(:post) { json['data']['posts'].last }

    it { should_not have_key "photo_content_type" }
    it { should_not have_key "photo_file_name" }
    it { should_not have_key "photo_file_size" }
    it { should_not have_key "photo_updated_at" }

    it "should have a photo_url" do
      post['photo_url'].should eq @post_with_photo.photo.url
    end
  end

  context "when a post has comments" do
    let(:place) { create(:place) }
    before do
      @post = create(:post, place: place)
      create(:comment, post: @post, text: "my text here")
      get api_v1_place_path(place.id), nil, set_token_auth_with_user
    end

    subject(:post) { json['data']['posts'].last }
    let(:first_comment) { post["comments"].first }

    it { should have_key "comments" }
    it "should have text" do
      first_comment["text"].should eq "my text here"
    end
    
    it "should have basic post_id" do
      first_comment["post_id"].should eq Comment.last.post.id.to_s
    end

    it "should have basic author_id" do
      first_comment["author_id"].should eq Comment.last.author.id.to_s
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

    it "should not return neighborhood" do
      json['data'].should_not have_key "neighborhood"
    end
  end

end

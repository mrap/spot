require 'spec_helper'

describe "creating a new post" do
  let(:place) { create(:place) }
  let(:user) { create(:user) }
  let(:post_attributes) { attributes_for(:post) }

  before do
    post api_v1_place_posts_path(place), { post: post_attributes }, set_token_auth_with_user(user)
  end

  let(:data) { json['data'] }

  it "returns the post's place" do
    data['id'].should eq place.id.to_s
  end

  it "should have the newly created place" do
    data['posts'].last['id'].should eq place.posts.last.id.to_s
  end

end

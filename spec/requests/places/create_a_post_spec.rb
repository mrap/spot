require 'spec_helper'

describe "creating a new post" do
  let(:place) { create(:place) }
  let(:user) { create(:user) }

  before do
    post api_v1_place_posts_path(place), nil, set_token_auth_with_user(user)
  end

  let(:data) { json['data'] }

  it "redirects to the post's place" do
    redirect_path = URI::parse(response.headers['Location']).path
    redirect_path.should match api_v1_places_path(place)
  end
end

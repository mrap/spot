require 'spec_helper'

describe Api::V1::PostsController do

  let(:user) { create(:user) }
  before { set_token_auth_with_user(user) }
  let(:place) { create(:place) }

  describe "POST /place/:place_id/posts" do
    let(:post_attributes) { attributes_for(:post) }
    before { post :create, place_id: place.id, post: post_attributes }
    subject { response }

    context "with valid post attributes" do
      it { should redirect_to api_v1_place_path(place) }

      it "should set the post's author to the current user" do
        place.posts.last.author.should eq user
      end
    end

    # At the moment,
    # it's impossible to send any invalid attributes.
    # Temporarily pending.
    context "with invalid post attributes" do
      let(:post_attributes) { {} }

      xit "returns a bad status code" do
        response.status.should eq 400
      end
    end
  end

end

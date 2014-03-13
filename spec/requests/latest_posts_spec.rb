require 'spec_helper'

describe "Getting the latest posts" do
  let(:data) { json['data'] }

  before do
    @older_posts = create_list(:post, 10)
    @newer_posts = create_list(:post, 10)
  end

  context "without any params" do
    before { get api_v1_latest_posts_path, nil, set_token_auth_with_user }
    it "should return the last 10 posts" do
      data.count.should eq 10
      # Array pushes the first created post to the last index.
      # The first in @newer posts is the oldest in that array.
      data.last["id"].should eq @newer_posts.first.id.to_s
    end
  end

  context "with a param `page`" do
    before { get api_v1_latest_posts_path, { page: 2 }, set_token_auth_with_user }
    it "should return the older posts" do
      data.count.should eq 10
      data.last["id"].should eq @older_posts.first.id.to_s
    end
  end
end

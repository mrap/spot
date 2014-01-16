require 'spec_helper'

# Stub ApiController
# get :index to test
class TestApiController < Api::V1::ApiController
  def index
    render nothing: true
  end

  test_routes = Proc.new do
      get '/index' => 'test_api#index'
  end
  Rails.application.routes.eval_block(test_routes)
end

describe TestApiController do
  describe "authenticating users" do

    context "with valid token" do
      it "should be successul" do
        set_token_auth_with_user
        get :index
        response.should be_successful
      end
    end

    context "with invalid token" do
      it "should return status unauthorized" do
        get :index
        response.status.should eq 401
      end
    end
  end
end

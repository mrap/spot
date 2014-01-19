module AuthenticationHelpers
  module TokenAuthentication
    def set_token_auth_with_user(user = nil)
      user ||= FactoryGirl.create(:user)
      api_key = FactoryGirl.create(:api_key, user: user)
      token = api_key.token

      if request # For controller specs
        request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
      else 
        # For request specs, use this method as your 3rd request parameter:
        # get :index, nil, set_token_auth_with_user
        { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(token) }
      end
    end
  end
end

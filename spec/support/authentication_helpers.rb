module AuthenticationHelpers
  module TokenAuthentication
    def set_token_auth_with_user(user = nil)
      user ||= FactoryGirl.create(:user)
      api_key = FactoryGirl.create(:api_key, user: user)
      token = api_key.token
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(token)
    end
  end
end

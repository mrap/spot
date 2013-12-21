class TokensController < ApplicationController

  before_action :authenticate_with_credentials!

  def create
    ApiKey.create(user: @user)
    render json: { token: @user.api_key.token }
  end

  protected

    def authenticate_with_credentials!
      if request.authorization
        decoded_credentials = Base64.decode64(request.authorization.split(' ', 2).last || '').split(/:/, 2)
        email = decoded_credentials[0]
        password = decoded_credentials[1]
        @user = User.where(email: email).first
      end
      raise_bad_request unless @user && @user.valid_password?(password)
    end
end

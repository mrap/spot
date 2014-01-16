class Api::V1::ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  respond_to :json

  before_action :authenticate_current_user

  def raise_bad_request_error
    render nothing: true, status: :bad_request and return
  end

  def raise_not_authorized_error
    render nothing: true, status: :unauthorized and return
  end

  def raise_not_found_error
    render nothing: true, status: :not_found and return
  end

  def current_user
    @current_user ||= authenticated_user_with_token ||
      authenticated_user_with_login_credentials
  end

  private

    def authenticate_current_user
      raise_not_authorized_error unless current_user
    end

    def authenticated_user_with_token
      ApiKey.find_user_with_token(decoded_token)
    end

    def authenticated_user_with_login_credentials
      login_credentials = decoded_credentials
      unless login_credentials.blank?
        email = login_credentials[0]
        password = login_credentials[1]
        user = User.where(email: email).first
        if user && user.valid_password?(password)
          return user
        else
          return nil
        end
      end
    end

    def decoded_credentials
      if request.authorization
        Base64.decode64(request.authorization.split(' ', 2).last || '').split(/:/, 2)
      end
    end

    def decoded_token
      token_and_options(request).first if token_and_options(request)
    end
end

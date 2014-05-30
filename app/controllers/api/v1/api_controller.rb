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
      registered_user_with_login_credentials
  end

  private

    # Forces the controller to set a current_user
    def authenticate_current_user
      raise_not_authorized_error unless current_user
    end

    # Returns a user if a valid token is present.
    # Else returns nil.
    def authenticated_user_with_token
      ApiKey.find_user_with_token(decoded_token)
    end

    # Returns a registered_user with given login credentials.
    # Else returns nil.
    def registered_user_with_login_credentials
      login_credentials = decoded_credentials
      unless login_credentials.blank?
        email = login_credentials[0]
        password = login_credentials[1]
        registered_user = RegisteredUser.where(email: email).first
        if registered_user && registered_user.valid_password?(password)
          return registered_user
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
      return nil unless token_and_options(request)
      token_str = token_and_options(request).first
      token_str.gsub(/[^0-9a-z]/i, '')
    end
end

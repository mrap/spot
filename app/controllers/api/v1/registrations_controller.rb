# Inspired by source: https://gist.github.com/jwo/1255275

class Api::V1::RegistrationsController < ApplicationController

  respond_to :json
  rescue_from ActionController::ParameterMissing, with: :bad_request

  def create
    if @registered_user = RegisteredUser.create!(registered_user_params)
      render json: { 
        data: { 
          token: @registered_user.api_key.token,
          expiration: @registered_user.api_key.expiration_date
        }
      }, status: 201
    else
      bad_request(@registered_user.errors)
    end
  end

  private
    def registered_user_params
      params.require(:registered_user).permit(:email, :username, :password)
    end

    def bad_request(errors = nil)
      errors ||= error
      render json: { 
        meta: {
          errors: errors
        }
      }, status: 422 
    end

end

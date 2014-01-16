# Inspired by source: https://gist.github.com/jwo/1255275

class Api::V1::RegistrationsController < ApplicationController

  respond_to :json

  def create
    user = User.new(params[:user])
    if user.save
      # Create a new api key for the new user.
      ApiKey.create!(user: user)
      render json: { token: user.api_key.token,
                     expiration: user.api_key.expiration_date },
                     status: 201
      return
    else
      render json: { errors: user.errors }, status: 422 
    end
  end

end

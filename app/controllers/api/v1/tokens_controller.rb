class Api::V1::TokensController < Api::V1::ApiController

  def create
    api_key = ApiKey.create!(user: current_user)
    render json: { token: api_key.token,
                   expiration: api_key.expiration_date }
  end

end

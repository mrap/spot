class Api::V1::TokensController < Api::V1::ApiController

  def create
    if current_user.api_key.refresh_token
      render json: { 
        data: { 
          token: current_user.api_key.token,
          expiration: current_user.api_key.expiration_date
        }
      }
    end
  end

end

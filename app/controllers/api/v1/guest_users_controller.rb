class Api::V1::GuestUsersController < Api::V1::ApiController

  skip_before_action :authenticate_current_user

  def create
    @guest_user = GuestUser.create!
    if @api_key = ApiKey.create(user: @guest_user)
      render json: { 
        data: { 
          token: @api_key.token,
          server_uid: @guest_user.unique_identifier.server_uid
        }
      }, status: :created
    end
  end
end

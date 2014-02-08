class Api::V1::GuestUsersController < Api::V1::ApiController

  skip_before_action :authenticate_current_user

  def create
    if @guest_user = GuestUser.create!
      render json: { 
        data: { 
          token: @guest_user.api_key.token,
          server_uid: @guest_user.unique_identifier.server_uid
        }
      }, status: :created
    end
  end
end

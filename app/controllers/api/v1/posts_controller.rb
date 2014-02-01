# Nested Controller
# Post belongs to Place.
class Api::V1::PostsController < Api::V1::ApiController
  before_action :get_place

  def create
    @post = @place.posts.new(params[:post])
    @post.author = current_user
    if @post.save
      redirect_to api_v1_place_path(@place)
    else
      render json: { meta: { errors: @post.errors } },
        status: :bad_request
    end
  end

  private

    def get_place
      @place = Place.where(id: params[:place_id]).first
      unless @place
        render nothing: true, status: :not_found and return
      end
    end
end

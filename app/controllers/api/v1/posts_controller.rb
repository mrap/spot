# Nested Controller
# Post belongs to Place.
class Api::V1::PostsController < Api::V1::ApiController
  before_action :get_place, only: [:create]

  def create
    @post = @place.posts.new(post_params)
    @post.author = current_user
    if @post.save
      render json: { data: @place },
        status: :created
    else
      render json: { meta: { errors: @post.errors } },
        status: :bad_request
    end
  end

  def index
    @posts = Post.recent.paginate(page: params[:page], limit: 10)
    render json: { data: @posts }, status: :success
  end

  private

    def get_place
      @place = Place.where(id: params[:place_id]).first
      unless @place
        render nothing: true, status: :not_found and return
      end
    end

    def post_params
      params.require(:post).permit(:description, :photo)
    end
end

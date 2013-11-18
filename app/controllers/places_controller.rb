class PlacesController < ApplicationController

  before_action :require_coordinates!, only: [:nearby]
  before_action :set_new_query, only: [:nearby]

  def nearby
    require_coordinates!
    @place_query.search_nearby_coordinates(@coordinates, radius: params[:radius], search_terms: params[:search_terms])
    render json: @place_query.results
  end

  private

    def set_new_query
      @place_query = PlaceQuery.new
    end

    def require_coordinates!
      if params[:longitude] && params[:latitude]
        @coordinates = Coordinates.new(params[:longitude], params[:latitude])
      end
      unless @coordinates
        render nothing: true, status: :bad_request and return
      end
    end
end

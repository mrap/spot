class PlacesController < ApplicationController

  before_action :require_coordinates!, only: [:nearby]
  before_action :set_new_query, only: [:nearby, :search_nearby, :search_in_locality]


  def nearby
    @place_query.search_nearby_coordinates(@coordinates, radius: params[:radius], search_terms: params[:search_terms])
    render json: @place_query.results
  end

  def search_nearby
    @place_query.search_places_nearby(search_terms: params[:search_terms], latitude: params[:latitude], longitude: params[:longitude], distance: params[:distance])
    render json: @factual_query.results
  end

  def search_in_locality
    if params[:locality]
      @factual_query.search_in_locality(search_terms: params[:search_terms], locality: params[:locality])
      render json: @factual_query.results
    end
  end

  private

    def set_new_query
      @place_query = PlaceQuery.new
    end

    def require_coordinates!
      set_coordinates
      unless @coordinates
        render nothing: true, status: :bad_request
      end
    end

    def set_coordinates
      if params[:longitude] && params[:latitude]
        @coordinates = Coordinates.new(params[:longitude], params[:latitude])
      end
    end
end

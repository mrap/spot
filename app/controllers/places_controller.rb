class PlacesController < ApplicationController

  before_action :set_new_query, only: [:nearby, :search_nearby, :search_in_locality]

  def nearby
    if coordinates = Location.new(coordinates: { latitude: params[:latitude], longitude: params[:longitude] })
      @query.places_near_coordinates_within_radius(coordinates, params[:distance])
      render json: @query.results
    end
  end

  def search_nearby
    @factual_query.search_places_nearby(search_terms: params[:search_terms], latitude: params[:latitude], longitude: params[:longitude], distance: params[:distance])
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
      @query = PlaceQuery.new
    end

end

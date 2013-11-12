class PlacesController < ApplicationController

  before_action :set_new_query, only: [:nearby, :search_nearby, :search_in_locality]

  def nearby
    @location_api.get_places_nearby(latitude: params[:latitude], longitude: params[:longitude], distance: params[:distance])
    render json: @location_api.results
  end

  def search_nearby
    @location_api.search_places_nearby(search_terms: params[:search_terms], latitude: params[:latitude], longitude: params[:longitude], distance: params[:distance])
    render json: @location_api.results
  end

  def search_in_locality
    if params[:locality]
      @location_api.search_in_locality(search_terms: params[:search_terms], locality: params[:locality])
      render json: @location_api.results
    end
  end

  private

    def set_new_query
      @location_api = LocationApi.new
    end

end

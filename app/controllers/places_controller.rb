class PlacesController < ApplicationController

  before_action :require_coordinates!, only: [:nearby]

  # Returns a list of places nearby coordinates. Places ordered by distance.
  # @param longitude of the coordinates
  # @param latitude of the coordinates
  # @option search_terms [String] words separated by spaces to search for places with matching names
  # @option radius distance in meters
  def nearby
    require_coordinates!
    place_query = PlaceQuery.new
    place_query.search_nearby_coordinates(@coordinates, radius: params[:radius], search_terms: params[:search_terms])
    @places = place_query.results
    render json: @places
  end

  private

    # Requires both `longitude` and `latitude` url params.
    # Else, renders nothing with `bad request` status code.
    def require_coordinates!
      if params[:longitude] && params[:latitude]
        @coordinates = Coordinates.new(params[:longitude], params[:latitude])
      end
      unless @coordinates
        render nothing: true, status: :bad_request and return
      end
    end
end

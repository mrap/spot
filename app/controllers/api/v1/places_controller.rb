class Api::V1::PlacesController < Api::V1::ApiController

  before_action :get_place, only: [:show]
  before_action :require_coordinates!, only: [:search]

  def show
    render json: { data: @place }
  end

  # Returns a list of places nearby coordinates. Places ordered by distance.
  # @param longitude of the coordinates
  # @param latitude of the coordinates
  # @option search_terms [String] words separated by spaces to search for places with matching names
  # @option radius distance in meters
  def search
    @places = FoursquarePlace.places_near_coordinates(@coordinates, query: params[:search_terms])
    render json: { data: @places }
  end

  private

    def get_place
      @place = Place.where(id: params[:id]).first
      unless @place
        render nothing: true, status: :not_found and return
      end
    end

    # Requires both `longitude` and `latitude` url params.
    # Else, renders nothing with `bad request` status code.
    def require_coordinates!
      if params[:longitude] && params[:latitude]
        @coordinates = Coordinates.new(params[:longitude].to_f, params[:latitude].to_f)
      end
      unless @coordinates
        render nothing: true, status: :bad_request and return
      end
    end
end

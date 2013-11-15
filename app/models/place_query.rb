class PlaceQuery
  include Mongoid::Document
  DEFAULT_PLACES_QUERY_LIMIT = 10

  field :results, type: Array,  default: nil

  after_initialize :factual_query

  def places_near_coordinates_within_radius(coordinates = nil, radius = ENV['DEFAULT_SEARCH_RADIUS'])

    unless coordinates.is_a?(Mongoid::Geospatial::Point)
      self.results = nil
      return
    end

    location = Location.new(coordinates: coordinates)

    # Get FactualPlaces (in database)
    database_places = location.nearby_within_distance_with_limit(radius, DEFAULT_PLACES_QUERY_LIMIT)

    # Get Factual API Places to results
    factual_api_refs = factual_query.get_places_near_coordinates_within_radius(coordinates, radius).to_a

    # Fill factual_api_places with FactualPlace instances built from api_refs.  Only non-duplicates.
    factual_api_places = []
    factual_api_refs.each do |api_ref|
      is_duplicate = false

      database_places.each do |db_place|
        if api_ref['factual_id'].eql? db_place.factual_id
          is_duplicate = true
          break
        end
      end

      factual_api_places << FactualPlace.build_from_api_ref(api_ref) unless is_duplicate
    end

    # Combine database_places and factual_api_places
    combined_places = database_places + factual_api_places

    # Sort by distance since all objects are subclasses of Location
    self.results = combined_places.sort { |p| p.distance_to(location) }

  end

  private

    def factual_query
      @factual_query ||= FactualQuery.new
    end

end

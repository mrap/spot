class PlaceQuery
  include Mongoid::Document
  DEFAULT_PLACES_QUERY_LIMIT = 10

  field :results, type: Array,  default: nil

  after_initialize :factual_query

  def search_nearby_coordinates(coordinates, options = {})
    return unless valid_coordinates?(coordinates)

    radius = options[:radius] || ENV['DEFAULT_SEARCH_RADIUS']

    # Get FactualPlaces (in database)
    # database_places = location.nearby_within_distance_with_limit(radius, DEFAULT_PLACES_QUERY_LIMIT)
    database_places = Place.nearby_coordinates(coordinates, radius: radius)

    # Get Factual API Places to results
    factual_api_refs = factual_query.get_places_near_coordinates_within_radius(coordinates, radius)

    # Fill factual_api_places with FactualPlace instances built from api_refs.  Only non-duplicates.
    merged_places = merge_places_with_api_refs(database_places, factual_api_refs)

    # Sort by distance since all objects are subclasses of Location
    self.results = merged_places.sort { |p| p.distance_to_coordinates(coordinates) }
  end

  private

    def merge_places_with_api_refs(places = [], api_refs = [])
      factual_places = []
      api_refs.each do |api_ref|
        is_duplicate = false
        places.each do |place|
          if api_ref['factual_id'].eql? place.factual_id
            is_duplicate = true
            break
          end
        end
        factual_places << FactualPlace.build_from_api_ref(api_ref) unless is_duplicate
      end
      return places + factual_places
    end

    def factual_query
      @factual_query ||= FactualQuery.new
    end

    def valid_coordinates?(coordinates)
      coordinates.is_a?(Mongoid::Geospatial::Point)
    end

end


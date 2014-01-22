class PlaceQuery
  include Mongoid::Document
  DEFAULT_PLACES_QUERY_LIMIT = 10
  DEFAULT_SEARCH_RADIUS = AppSettings::QUERY[:default_search_radius]

  def search_nearby_coordinates(coordinates, options = {})
    return unless valid_coordinates?(coordinates)

    radius = options[:radius] || DEFAULT_SEARCH_RADIUS

    # Get all factual references.
    factual_query = FactualQuery.new
    factual_query.nearby_coordinates(coordinates, search_terms: options[:search_terms], radius: radius)

    # Save each result as a FactualPlace.
    factual_query.results.each do |factual_ref|
      FactualPlace.create_from_api_ref(factual_ref)
    end

    # Get all places near coordinates.
    # Including the new factual places.
    if options[:search_terms]
      places = Place.nearby_coordinates(coordinates, radius: radius).full_text_search(options[:search_terms])
    else
      places = Place.nearby_coordinates(coordinates, radius: radius)
    end

    return places
  end

  private

    def valid_coordinates?(coordinates)
      coordinates.is_a?(Mongoid::Geospatial::Point)
    end

end


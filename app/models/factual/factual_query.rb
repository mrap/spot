# Simplified way to query the Factual API for places.
#
# Querying is easy!
#
#   1. Build a new FactualQuery
#       fq = FactualQuery.new
#   2. Query by using a query method
#       fq.nearby_coordinates(coordinates, radius: 500)
#   3. Get results
#       fq.results
#
require 'factual'

class FactualQuery
  include Mongoid::Document
  DEFAULT_SEARCH_RADIUS = AppSettings::QUERY[:default_search_radius]

  after_initialize :set_initial_query

  # Sets @query ivar to query for factual place refs located nearby given coordinates.
  # @param  coordinates [Coordinates] center of query
  # @option radius limit in meters
  # @option search_terms [String] limit to only places with names that match search_terms
  def nearby_coordinates(coordinates, options = {})
    add_nearby_to_query(coordinates: coordinates, radius: options[:radius])
    add_search_terms_to_query(search_terms: options[:search_terms]) if options[:search_terms]
  end

  # Sets @query ivar to query for factual place refs with specific names, within a specific locality
  # Locality means the same as "city" in this case.
  # @param search_terms [String] limits results to places with matching names
  # @param locality [String] city to search within
  def search_places_in_locality(search_terms = nil, locality = nil)
    if search_terms && locality
      add_search_terms_to_query(search_terms: search_terms)
      add_locality_to_query(locality: locality)
    end
  end

  # Returns results of @query
  def results
    return @query.rows
  end

  # Returns the first result of @query
  def result
    return @query.first
  end

  private

    def set_initial_query
      factual = Factual.new(ENV['FACTUAL_API_KEY'], ENV['FACTUAL_API_SECRET'])
      @query = factual.table("places")
      # other factual tables: 
      # http://developer.factual.com/data-docs/
    end

    def add_nearby_to_query(options = {})
      radius = options[:radius] || DEFAULT_SEARCH_RADIUS
      coordinates = options[:coordinates]
      @query = @query.geo("$circle" => {"$center" => [coordinates.latitude, coordinates.longitude], "$meters" => radius }) if coordinates && radius
    end

    def add_search_terms_to_query(options = {})
      search_terms  = options[:search_terms]
      @query = @query.search(*search_terms) if search_terms
    end

    def add_locality_to_query(options = {})
      locality = options[:locality]
      @query = @query.filters("locality" => locality)
    end

end

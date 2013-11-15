require 'factual'

class FactualQuery
  include Mongoid::Document

  after_initialize :set_initial_query

  def get_places_near_coordinates_within_radius(coordinates = nil, radius = nil)
    if coordinates
      add_nearby_to_query(coordinates: coordinates, radius: radius)
    end
  end

  def search_places_in_locality(search_terms = nil, locality = nil)
    if search_terms && locality
      add_search_terms_to_query(search_terms: search_terms)
      add_locality_to_query(locality: locality)
    end
  end

  def search_places_near_coordinates_within_radius(search_terms = nil, coordinates = nil, radius = nil)
    if search_terms && coordinates
      add_nearby_to_query(coordinates: coordinates, radius: radius)
      add_search_terms_to_query(search_terms: search_terms)
    end
  end

  def results
    return @query.rows
  end

  def result
    return @query.first
  end

  private

    def set_initial_query
      factual = Factual.new(ENV['FACTUAL_API_KEY'], ENV['FACTUAL_API_SECRET'])
      @query = factual.table("places-edge")
    end

    def add_nearby_to_query(options = {})
      radius = options[:radius] || ENV['DEFAULT_SEARCH_RADIUS']
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

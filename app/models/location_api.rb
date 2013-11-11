require 'factual'



class LocationApi
  include Mongoid::Document

  after_initialize :set_initial_query

  def search_in_locality(options = {})
    add_search_terms_to_query(options)
    add_locality_to_query(options)
  end

  def search_places_nearby(options = {})
    add_nearby_to_query(options)
    add_search_terms_to_query(options)
  end

  def get_places_nearby(options = {})
    add_nearby_to_query(options)
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
      distance  = options[:distance] || ENV['FACTUAL_DEFAULT_DISTANCE']
      latitude  = options[:latitude]
      longitude = options[:longitude]
      @query = @query.geo("$circle" => {"$center" => [latitude, longitude], "$meters" => distance}) if latitude && longitude && distance
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

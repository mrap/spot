require 'factual'



class LocationApi
  include Mongoid::Document

  after_initialize :set_initial_query

  def search_with_distance_from_center(options = {})
    add_nearby_to_query(options)
    search_terms  = options[:search_terms]
    @query = @query.search(*search_terms) if search_terms
    fetch_results
  end

  def get_places_nearby(options = {})
    add_nearby_to_query(options)
    fetch_results
  end

  def fetch_results
    return @query.rows
  end

  private

    def set_initial_query
      factual = Factual.new(ENV['FACTUAL_API_KEY'], ENV['FACTUAL_API_SECRET'])
      @query = factual.table("places-edge")
    end

    def add_nearby_to_query(options = {})
      distance = options[:distance] || FACTUAL_DEFAULT_DISTANCE
      center   = options[:center]
      @query = @query.geo("$circle" => {"$center" => center, "$meters" => distance}) if center && distance
    end

end

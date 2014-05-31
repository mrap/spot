class GooglePlace
  # include Mongoid::Document

  def self.places_with_coordinates(coordinates)
    return [] unless coordinates.latitude && coordinates.longitude
    GooglePlacesClient.spots(coordinates.latitude, coordinates.longitude, {rankby: 'distance', keyword: '*'} )
  end

end

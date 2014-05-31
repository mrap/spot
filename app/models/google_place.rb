class GooglePlace < Place

  field :google_id
  validates :google_id, presence: true, uniqueness: true

  def self.places_with_coordinates(coordinates)
    return [] unless coordinates.latitude && coordinates.longitude
    places = GooglePlacesClient.spots(coordinates.latitude, coordinates.longitude, {rankby: 'distance', keyword: '*'} )
    places.collect { |place_ref| GooglePlace.find_or_create_from_api_ref(place_ref) }
  end

  def self.create_from_api_ref(ref)
    return nil unless ref

    place             = GooglePlace.new
    place.google_id   = ref.id if ref.id
    place.name        = ref.name if ref.name
    place.address     = ref.vicinity if ref.vicinity
    place.coordinates = Coordinates.new_with_lat_long(ref.lat, ref.lng)

    return place if place.save
    raise "Place was not created!"
  end

  def self.find_or_create_from_api_ref(ref)
    return nil unless ref
    GooglePlace.where(google_id: ref.id).first || GooglePlace.create_from_api_ref(ref)
  end

end

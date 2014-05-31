class FoursquarePlace < Place

  field :foursquare_id
  validates :foursquare_id, presence: true, uniqueness: true

  def serializable_hash(options = {})
    hash = super(options)
    hash[:foursquare_id] = self.foursquare_id || nil
    return hash
  end

  FOURSQUARE_SEARCH_LIMIT = 50

  def self.places_near_coordinates(coordinates, options={} )
    request = FoursquareClient.search_venues(ll: "#{coordinates.latitude}, #{coordinates.longitude}", 
                                             limit: FOURSQUARE_SEARCH_LIMIT,
                                             query: options[:query] )

    places = request.venues
    places.collect! { |place_ref| FoursquarePlace.find_or_create_from_api_ref(place_ref) }
  end

  def self.create_from_api_ref(ref)
    return nil unless ref && ref.location.lat && ref.location.lng

    place               = FoursquarePlace.new
    place.foursquare_id = ref.id               || nil
    place.name          = ref.name             || nil
    place.address       = ref.location.address || nil
    place.locality      = ref.location.city    || nil
    place.region        = ref.location.state   || nil
    place.country       = ref.location.country || nil
    place.coordinates   = Coordinates.new_with_lat_long(ref.location.lat, ref.location.lng)

    return place if place.save
    raise "Place was not created!"
  end

  def self.find_or_create_from_api_ref(ref)
    return nil unless ref
    FoursquarePlace.where(foursquare_id: ref.id).first || FoursquarePlace.create_from_api_ref(ref)
  end
end

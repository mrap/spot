class PlaceQuery
  include Mongoid::Document
  include Mongoid::Geospatial

  field :results, type: Array,  default: nil
  field :radius,  type: Float,  default: nil
  geo_field :center, default: nil

end

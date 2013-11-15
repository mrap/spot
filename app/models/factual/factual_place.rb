class FactualPlace < Place
  include Mongoid::Document

  field :factual_id,      type: String
  field :category_labels, type: Array
  field :hours,           type: String
  field :tel,             type: String

  validates_presence_of :factual_id

  def self.create_from_api_ref(ref)
    valid_attributes = filter_only_valid_attributes(ref)
    FactualPlace.create!(valid_attributes)
  end

  def self.build_from_api_ref(ref)
    valid_attributes = filter_only_valid_attributes(ref)
    FactualPlace.new(valid_attributes)
  end

  private

    def self.filter_only_valid_attributes(attributes = {})
      latitude  = attributes['latitude']
      longitude = attributes['longitude']
      if latitude && longitude
        valid_attributes = {}
        valid_attributes[:coordinates] = { latitude: latitude, longitude: longitude }
        attributes.each_pair do |key, value|
          valid_attributes[key] = value if self.fields.keys.include? key
        end

        return valid_attributes
      end
    end

end

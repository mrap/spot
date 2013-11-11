require 'spec_helper'

describe Place do

  # Relations
  it { should have_many :posts }

  # Fields
  it { should have_fields :name,
                          :address,
                          :address_extended,
                          :locality,
                          :region,
                          :country,
                          :postcode,
                          :longitude,
                          :latitude,
                          :neighborhood }

  # Validations
  it { should validate_presence_of :name }

end

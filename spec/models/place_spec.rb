require 'spec_helper'

describe Place do
  it { should be_kind_of(Location)}

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
                          :neighborhood }

  # Validations
  it { should validate_presence_of :name }

end

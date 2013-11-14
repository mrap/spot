require 'spec_helper'

describe PlaceQuery do

  it { should have_field(:results).with_default_value_of(nil) }
  it { should have_field(:center).with_default_value_of(nil) }
  it { should have_field(:radius).with_default_value_of(nil) }

end

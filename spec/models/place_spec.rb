require 'spec_helper'

describe Place do

  it { should have_field :name }
  it { should validate_presence_of :name }

end

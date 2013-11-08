require 'spec_helper'

describe User do

  it { should have_field :username }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

end

require 'spec_helper'

describe RegisteredUser do
  it { should have_field :username }
  it { should have_field(:score).of_type(Integer).with_default_value_of(0) }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }
end

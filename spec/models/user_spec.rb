require 'spec_helper'

describe User do

  it { should have_many(:posts).as_inverse_of(:author) }
  it { should have_and_belong_to_many(:helpful_posts).of_type(Post).as_inverse_of(:helped_users) }
  it { should have_field :username }
  it { should have_field(:score).of_type(Integer).with_default_value_of(0) }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

end

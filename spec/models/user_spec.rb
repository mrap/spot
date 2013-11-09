require 'spec_helper'

describe User do

  it { should have_many :posts }
  it { should have_and_belong_to_many(:helpful_posts).of_type(Post).as_inverse_of(:helped_users) }
  it { should have_field :username }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

end

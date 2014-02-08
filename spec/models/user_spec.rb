require 'spec_helper'

describe User do

  it { should have_many(:posts).as_inverse_of(:author) }
  it { should have_and_belong_to_many(:helpful_posts).of_type(Post).as_inverse_of(:helped_users) }
  it { should have_many(:questions).as_inverse_of(:asker) }
  it { should have_one(:api_key) }
  it { should have_many(:comments).as_inverse_of(:author).with_dependent(:destroy) }
  it { should have_field(:score).of_type(Integer).with_default_value_of(0) }

  subject(:user) { create(:user) }
  its(:api_key) { should_not be_nil }

end

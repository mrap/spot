require 'spec_helper'

describe Post do

  it { should belong_to :user }
  it { should belong_to :post }
  it { should have_field :created_at }
  it { should have_field :description }

end

require 'spec_helper'

describe Post do
  it { should have_field :created_at }
  it { should have_field :description }
end

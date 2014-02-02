require 'spec_helper'

describe Comment do
  it { should have_field :created_at }
  it { should have_field :text }
  it { should belong_to :post }
  it { should belong_to(:author).of_type(User) }
  it { should validate_length_of(:text).with_minimum(1).with_maximum(300) }

  describe "factory" do
    subject(:comment) { create(:comment) }
    it { should_not be_nil }
    its(:post)   { should_not be_nil }
    its(:author) { should_not be_nil }
  end
end

require 'spec_helper'

describe Post do

  it { should belong_to :user }
  it { should belong_to :post }
  it { should have_field :created_at }
  it { should have_field :description }

  it "should have an attachment :photo", :slow do
    post = create(:post_with_photo)
    post.photo.url.should_not be_nil
  end

end

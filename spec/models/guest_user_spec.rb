require 'spec_helper'

describe GuestUser do
  it { should be_kind_of User }
  it { should have_one(:unique_identifier).with_autobuild }
  it { should validate_presence_of :unique_identifier }

  subject(:guest_user) { create(:guest_user) }
  it { should_not be_nil }
end

require 'spec_helper'

describe UniqueIdentifier do
  it { should belong_to :guest_user }
  it { should have_field(:server_uid).of_type(String) }
  it { should validate_uniqueness_of :server_uid }
  it { should validate_presence_of :server_uid }

  subject(:unique_id) { create(:unique_identifier) }
  it "should generate a server uid" do
    unique_id.server_uid.should_not be_nil
  end
end

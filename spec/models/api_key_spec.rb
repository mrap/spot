require 'spec_helper'

describe ApiKey do
  it { should belong_to :user }
  it { should have_field :token }

  describe "instance of ApiKey" do
    subject(:api_key) { create(:api_key) }
    its(:token) { should_not be_nil }
  end
end

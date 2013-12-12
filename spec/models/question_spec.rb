require 'spec_helper'

describe Question do
  it { should belong_to(:asker).of_type(User) }
  it { should belong_to(:place) }
  it { should have_many :answers }
  it { should validate_presence_of :asker }
  it { should validate_presence_of :place }
  it { should have_field(:message).of_type(String) }

  describe "instantiating" do
    subject(:question) { create(:question) }
    it { should_not be_nil }
  end
end

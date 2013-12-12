require 'spec_helper'

describe Answer do
  it { should be_kind_of Post }
  it { should belong_to(:question) }
  it { should validate_presence_of :question }

  subject(:answer) { create(:answer) }
  describe "instantiating from a factory" do
    it { should_not be_nil }
  end

  describe "creating an answer" do
    let(:question) { create(:question) }
    it "automatically sets it's place to question's place" do
      answer = Answer.create(question: question)
      answer.place.should eq question.place
    end
  end
end

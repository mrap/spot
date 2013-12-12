require 'spec_helper'

describe Answer do
  it { should be_kind_of Post }
  it { should belong_to(:question) }
  it { should validate_presence_of :question }

  subject(:answer) { create(:answer) }
  let(:question)   { answer.question }

  describe "creating an answer" do
    it "automatically sets it's place to question's place" do
      answer = Answer.create(question: question)
      answer.place.should eq question.place
    end
  end

  describe "checking if it is the question's accepted answer" do
    context "when it is the question's accepted answer" do
      before { question.accept_answer(answer) }
      it "should return true" do
        answer.accepted_answer?.should eq true
      end
    end
    context "when it is not question's accepted answer" do
      it "should return false" do
        answer.accepted_answer?.should eq false
      end
    end
  end
end

require 'spec_helper'

describe Question do
  it { should belong_to(:asker).of_type(User) }
  it { should belong_to(:place) }
  it { should have_many :answers }
  it { should validate_presence_of :asker }
  it { should validate_presence_of :place }
  it { should have_field(:message).of_type(String) }
  it { should have_field(:accepted_answer_id).of_type(BSON::ObjectId) }

  subject(:question) { create(:question) }

  describe "accepting one answer" do
    context "when answer is in answers" do
      let(:answer) { create(:answer, question: question) }
      before { question.accept_answer(answer) }
      its(:accepted_answer_id) { should eq answer.id }
      its(:accepted_answer)    { should eq answer }
    end
    context "when answer not in answers" do
      let(:answer) { create(:answer) }
      before { question.accept_answer(answer) }
      its(:accepted_answer_id) { should_not eq answer.id }
      its(:accepted_answer)    { should_not eq answer }
    end
  end
end

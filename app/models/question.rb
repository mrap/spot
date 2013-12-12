class Question
  include Mongoid::Document
  
  belongs_to :asker, class_name: "User"
  belongs_to :place
  has_many   :answers

  validates_presence_of :asker, :place

  field :message,            type: String
  field :accepted_answer_id, type: BSON::ObjectId

  def accepted_answer
    Answer.where(id: accepted_answer_id).first
  end

  def accept_answer(answer)
    self.accepted_answer_id = answer.id if answers.include?(answer)
  end

end

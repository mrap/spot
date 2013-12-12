class Answer < Post

  belongs_to :question
  validates_presence_of :question

  before_validation { self.place = question.place }

  # Returns true if it is the question's accepted answer
  def accepted_answer?
    self == question.accepted_answer
  end

end

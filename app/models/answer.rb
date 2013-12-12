class Answer < Post

  belongs_to :question
  validates_presence_of :question

  before_validation { self.place = question.place }

end

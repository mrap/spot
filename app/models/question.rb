class Question
  include Mongoid::Document
  
  belongs_to :asker, class_name: "User"
  belongs_to :place
  has_many   :answers

  validates_presence_of :asker, :place

  field :message, type: String

end

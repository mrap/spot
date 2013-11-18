class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :initiator, class_name: "User", inverse_of: :events

  field :score_change, type: Integer, default: 0
  field :description,  type: String

  after_create :update_initiator_score
  before_create :set_default_description

  private

    def set_default_description
      self.description ||= "Event created on #{self.created_at}, initiated by #{self.initiator}"
    end

    def update_initiator_score
      self.initiator.score += self.score_change if self.initiator.score
    end

end

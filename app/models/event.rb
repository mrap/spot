class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :initiator, class_name: "User", inverse_of: :events

  field :base_score,   type: Integer, default: ENV['BASE_SCORE'].to_i
  field :score_change, type: Integer, default: 0
  field :score_bonus,  type: Integer, default: 0
  field :description,  type: String

  after_create :update_initiator_score
  before_create :set_default_description

  private

    def set_default_description
      self.description ||= "Event created on #{self.created_at}, initiated by #{self.initiator}"
    end

    def update_initiator_score
      self.score_change = self.base_score + self.score_bonus
      if self.initiator.score
        self.initiator.score += self.score_change
      end
    end

end

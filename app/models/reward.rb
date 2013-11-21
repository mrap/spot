class Reward
  include Mongoid::Document
  include Mongoid::Timestamps
  BASE_SCORE = AppConstants::REWARD[:base_score]

  belongs_to :giver, class_name: "User", inverse_of: :rewards_given
  belongs_to :receiver, class_name: "User", inverse_of: :rewards_received

  field :base_score,   type: Integer, default: BASE_SCORE
  field :score_change, type: Integer, default: 0
  field :score_bonus,  type: Integer, default: 0

  after_create :update_receiver_score

  private

    def update_receiver_score
      self.score_change += self.score_bonus
      if self.receiver.score
        self.receiver.score += self.score_change
      end
    end

end

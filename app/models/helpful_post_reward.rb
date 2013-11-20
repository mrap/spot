class HelpfulPostReward < Reward
  belongs_to :post

  validates_presence_of :post

  before_create :set_giver_and_receiver, :add_score_bonus

  private

    def set_giver_and_receiver
      self.receiver = self.post.author
    end

    def add_score_bonus
      self.score_bonus += self.base_score / 5
    end

end

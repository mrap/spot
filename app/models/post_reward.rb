class PostReward < Reward
  belongs_to :post

  validates_presence_of :post

  before_create :set_giver_and_receiver_to_post_author, :set_default_score, :add_score_bonuses

  def bonus_scores
    {
      first_post: base_score * 4
    }
  end

  private

    def set_giver_and_receiver_to_post_author
      self.giver    = self.post.user
      self.receiver = self.post.user
    end

    def set_default_score
      self.score_change = self.base_score
    end

    # Score Logic

    def add_score_bonuses
      self.score_bonus += bonus_scores[:first_post] if first_post?
    end

    def first_post?
      place = self.post.place
      self.post == place.posts.first
    end

end

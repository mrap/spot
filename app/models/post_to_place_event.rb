class PostToPlaceEvent < Event
  belongs_to :place
  belongs_to :post

  validates_presence_of :place, :post

  before_create :set_initiator_to_post_user, :add_score_bonuses

  def bonus_scores
    {
      first_post: base_score * 4
    }
  end

  private

    def set_initiator_to_post_user
      self.initiator = self.post.user
    end

    # Score Logic

    def add_score_bonuses
      self.score_bonus += bonus_scores[:first_post] if first_post?
    end

    def first_post?
      self.post == self.place.posts.first
    end

end

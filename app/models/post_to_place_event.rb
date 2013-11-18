S_B_FIRST_POST = 40
S_DEFAULT      = 10

class PostToPlaceEvent < Event
  belongs_to :place
  belongs_to :post

  validates_presence_of :place, :post

  before_create :set_initiator_to_post_user, :add_score_bonuses

  private

    def set_initiator_to_post_user
      self.initiator = self.post.user
    end

    # Score Logic

    def add_score_bonuses
      self.score_change = S_DEFAULT
      self.score_change += S_B_FIRST_POST if first_post?
    end

    def first_post?
      self.post == self.place.posts.first
    end

end

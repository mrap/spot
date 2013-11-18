class PostToPlaceEvent < Event

  belongs_to :place
  belongs_to :post

  validates_presence_of :place, :post

  before_create :set_initiator_to_post_user

  private

    def set_initiator_to_post_user
      self.initiator = self.post.user
    end

end

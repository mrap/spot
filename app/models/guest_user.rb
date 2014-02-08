class GuestUser < User
  has_one :unique_identifier

  before_validation :generate_unique_identifier
  validates_presence_of :unique_identifier

  private
    def generate_unique_identifier
      UniqueIdentifier.create(guest_user: self)
    end
end

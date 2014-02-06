class GuestUser < User
  has_one :unique_identifier

  validates_presence_of :unique_identifier
end

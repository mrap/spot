class GuestUser < User
  has_one :unique_identifier, autobuild: true

  validates_presence_of :unique_identifier
end

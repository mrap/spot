class UniqueIdentifier
  include Mongoid::Document

  belongs_to :guest_user

  field :server_uid, type: String
  validates :server_uid, presence: true, uniqueness: true

  before_validation :assign_server_uid

  private
    def assign_server_uid
       self.server_uid ||= UniqueIdentifier.unique_server_id
    end

    def self.unique_server_id
      loop do
        new_id = SecureRandom.hex
        return new_id unless UniqueIdentifier.where(server_uid: new_id).exists?
      end
    end

end


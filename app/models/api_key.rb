class ApiKey
  include Mongoid::Document

  belongs_to :user
  field :token

  before_create :refresh_token

  def refresh_token
    self.token = ApiKey.unique_token
  end

  private

    def self.unique_token
      new_token = SecureRandom.hex(64)
      return new_token unless ApiKey.where(token: new_token).exists?
    end
end

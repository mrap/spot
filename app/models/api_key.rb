class ApiKey
  include Mongoid::Document
  EXPIRATION_INTERVAL = AppSettings::API_KEY[:expiration_interval]
 
  belongs_to :user
  field :token
  field :expiration_date, type: DateTime
  
  before_validation :generate_token
  validates :token, presence: true, uniqueness: true
  validates :expiration_date, presence: true

  def generate_token
    self.token ||= ApiKey.unique_token
    self.expiration_date ||= Time.now.advance(seconds: EXPIRATION_INTERVAL)
  end

  def refresh_token
    self.token = ApiKey.unique_token
    self.expiration_date = Time.now.advance(seconds: EXPIRATION_INTERVAL)
  end

  def self.find_user_with_token(token)
    api_key = ApiKey.where(token: token).first
    api_key.user if api_key
  end

  def expired?
    self.expiration_date <= Time.now
  end

  private

    def self.unique_token
      new_token = SecureRandom.hex(64)
      return new_token unless ApiKey.where(token: new_token).exists?
    end
end

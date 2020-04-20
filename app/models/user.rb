class User < ApplicationRecord
  before_create :set_api_key
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email

  private
    def set_api_key
      return if api_key.present?
      self.api_key = generate_api_key
    end

    def generate_api_key
      SecureRandom.uuid.gsub(/\-/,'')
    end
end

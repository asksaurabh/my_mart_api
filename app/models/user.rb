class User < ApplicationRecord
  validates :email, presence: true, length: { maximum: 255 }, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password_digest, presence: true 
  has_secure_password
end

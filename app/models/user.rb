class User < ApplicationRecord
  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8 }
end

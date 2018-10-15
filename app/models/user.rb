class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name,  presence: true, length: {maximum: Settings.user.validate.name_max_len}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user.validate.email_max_len},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user.validate.password_min_len}
end

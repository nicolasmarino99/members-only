# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :create_remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :posts

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_remember_token
    remember_token = User.new_token
    self.remember_digest = Digest::SHA1.hexdigest(remember_token)
  end
end

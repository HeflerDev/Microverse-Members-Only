class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :set_first_remember_digest

  has_secure_password
  has_many :posts

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  private

  def set_first_remember_digest
    digest = User.digest(User.new_token)
    self.remember_digest = digest
  end
end

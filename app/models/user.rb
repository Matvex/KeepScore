class User < ApplicationRecord
  has_secure_password

  has_many :game_sessions, dependent: :destroy

  validates :username, presence: true, uniqueness: true
end

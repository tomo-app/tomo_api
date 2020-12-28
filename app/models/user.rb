class User < ApplicationRecord
  has_secure_password

  has_and_belongs_to_many :pairings
  has_many :blocked_pairings, foreign_key: 'blocking_user_id', class_name: 'BlockedPairing'
  has_many :user_languages
  has_many :languages, through: :user_languages
  has_many :availabilities

  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :username, uniqueness: true, presence: true
end

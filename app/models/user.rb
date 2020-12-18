class User < ApplicationRecord
  has_and_belongs_to_many :pairings
  has_many :blocked_pairings
  has_many :user_languages
  has_many :languages, through: :user_languages

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :username, uniqueness: true, presence: true
end

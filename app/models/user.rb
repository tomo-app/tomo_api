class User < ApplicationRecord
  has_secure_password

  has_many :pairings, dependent: :destroy
  has_many :pairings, foreign_key: 'user1_id', class_name: 'Pairing', dependent: :destroy, inverse_of: :user1
  has_many :pairings, foreign_key: 'user2_id', class_name: 'Pairing', dependent: :destroy, inverse_of: :user2
  has_many :blocked_pairings, foreign_key: 'blocking_user_id', class_name: 'BlockedPairing', dependent: :destroy,
                              inverse_of: :blocking_user
  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages
  has_many :availabilities, dependent: :destroy

  validates :email, uniqueness: true, presence: true
  validates :password_digest, presence: true
  validates :username, uniqueness: true, presence: true

  def blocked_ids
    blocked_pairings.map { |blocked| blocked.blocked_user.id }
  end
end

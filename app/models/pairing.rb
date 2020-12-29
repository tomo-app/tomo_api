class Pairing < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  validates :date_time, presence: true
  validates :user1_cancelled?, presence: true
  validates :user2_cancelled?, presence: true
end

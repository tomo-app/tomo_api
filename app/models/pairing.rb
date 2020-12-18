class Pairing < ApplicationRecord
  has_and_belongs_to_many :users

  validates :date_time, presence: true
  validates :cancelled?, presence: true
end

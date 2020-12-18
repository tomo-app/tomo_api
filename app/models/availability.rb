class Availability < ApplicationRecord
  belongs_to :users

  validates :start_date_time, presence: true
  validates :end_date_time, presence: true
  validates :status, presence: true

  enum status: { 'open': 0, 'fulfilled': 1, 'cancelled': 2}
end

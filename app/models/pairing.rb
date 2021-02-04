class Pairing < ApplicationRecord
  belongs_to :user1, class_name: 'User'
  belongs_to :user2, class_name: 'User'

  validates :date_time, presence: true

  def self.create_pairing(availability, open_slot)
    pairing_time = determine_time_of_pairing(availability, open_slot[0])
    Pairing.create!(user1: availability.user, user2: open_slot[0].user, date_time: pairing_time,
                    user1_cancelled?: false, user2_cancelled?: false)
  end

  def self.determine_time_of_pairing(availability1, availability2)
    if availability1.start_date_time > availability2.start_date_time
      availability1.start_date_time
    else
      availability2.start_date_time
    end
  end

  def cancelled?
    user1_cancelled? || user2_cancelled?
  end
end

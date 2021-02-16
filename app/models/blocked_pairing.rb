class BlockedPairing < ApplicationRecord
  belongs_to :blocking_user, class_name: 'User'
  belongs_to :blocked_user, class_name: 'User'

  def self.blocked_pairing_exists?(blocking_user_id, blocked_user_id)
    !BlockedPairing.where(blocking_user_id: blocking_user_id, blocked_user_id: blocked_user_id).empty?
  end
end

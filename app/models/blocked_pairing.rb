class BlockedPairing < ApplicationRecord
  belongs_to :blocking_user, class_name: 'User'
  belongs_to :blocked_user, class_name: 'User'
end

module Types
  module Input
    class BlockedPairingInputType < Types::BaseInputObject
      argument :blocking_user_id, ID, required: true
      argument :blocked_user_id, ID, required: true
    end
  end
end

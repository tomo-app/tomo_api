module Mutations
  module BlockedPairings
    class CreateBlockedPairing < ::Mutations::BaseMutation
      argument :params, Types::Input::BlockedPairingInputType, required: true

      type Types::BlockedPairingType

      def resolve(params:)
        blocked_pairing_params = Hash params
        BlockedPairing.create(
          blocking_user_id: blocked_pairing_params[:blocking_user_id],
          blocked_user_id: blocked_pairing_params[:blocked_user_id]
        )
      end
    end
  end
end

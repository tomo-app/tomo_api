module Mutations
  module BlockedPairings
    class CreateBlockedPairing < ::Mutations::BaseMutation
      argument :params, Types::Input::BlockedPairingInputType, required: true

      type Types::BlockedPairingType

      def resolve(params:)
        blocked_pairing_params = Hash params
        return handle_already_exists_error if BlockedPairing.blocked_pairing_exists?(
          blocked_pairing_params[:blocking_user_id], blocked_pairing_params[:blocked_user_id]
        )

        BlockedPairing.create(
          blocking_user_id: blocked_pairing_params[:blocking_user_id],
          blocked_user_id: blocked_pairing_params[:blocked_user_id]
        )
      end

      def handle_already_exists_error
        GraphQL::ExecutionError.new('this user has already been blocked')
      end
    end
  end
end

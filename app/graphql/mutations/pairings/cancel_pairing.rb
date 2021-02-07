module Mutations
  module Pairings
    class CancelPairing < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :user_id, ID, required: true
      type Types::PairingType

      def resolve(arguments)
        pairing = Pairing.find(arguments[:id])
        if pairing[:user1_id] == arguments[:user_id].to_i
          pairing.update(user1_cancelled: true)
        else
          pairing.update(user2_cancelled: true)
        end
        pairing
      end
    end
  end
end

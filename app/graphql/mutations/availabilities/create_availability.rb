module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
      argument :params, Types::Input::AvailabilityInputType, required: true
      type Types::AvailabilityType

      def resolve(params:)
        availability_params = Hash params
        availability = Availability.create(availability_params)
        open_slot = availability.find_availabilities_to_pair
        Pairing.create_pairing(availability, open_slot) if open_slot != nil
        availability
      end
    end
  end
end

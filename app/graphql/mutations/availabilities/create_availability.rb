module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
      argument :params, Types::Input::AvailabilityInputType, required: true
      type Types::AvailabilityType

      def resolve(params:)
        availability_params = Hash params
        availability = Availability.create(availability_params)
        open_slot = availability.find_availabilities_to_pair
        pairing = Pairing.create_pairing(availability, open_slot) unless open_slot.nil?
        availability.update(status: 'fulfilled') unless pairing.nil?
        open_slot[0].update(status: 'fulfilled') unless pairing.nil?
        availability
      end
    end
  end
end

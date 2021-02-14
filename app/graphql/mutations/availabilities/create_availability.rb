module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
      argument :params, Types::Input::AvailabilityInputType, required: true
      type Types::AvailabilityType

      def resolve(params:)
        availability_params = Hash params
        availability = Availability.create(availability_params)
        schedule_pairing(availability) if availability
        availability
      end

      def schedule_pairing(availability)
        open_slot = availability.availabilities_to_pair
        unless open_slot.empty?
          Pairing.create_pairing(availability, open_slot)
          availability.update(status: 'fulfilled')
          open_slot[0].update(status: 'fulfilled')
        end
      end
    end
  end
end

module Mutations
  module Availabilities
    class UpdateAvailability < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :start_date_time, Integer, required: false
      argument :end_date_time, Integer, required: false
      argument :status, Integer, required: false

      type Types::AvailabilityType

      def resolve(arguments)
        availability = Availability.find(arguments[:id])
        arguments.delete(:id)
        availability.update(arguments)
        schedule_pairing(availability) if availability
        availability
      end

      def schedule_pairing(availability)
        if availability.status != 'cancelled' && availability.status != 'fulfilled'
          open_slot = availability.find_availabilities_to_pair
          pairing = Pairing.create_pairing(availability, open_slot) unless open_slot.empty?
          availability.update(status: 'fulfilled') unless pairing.nil?
          open_slot[0].update(status: 'fulfilled') unless pairing.nil?
        end
      end
    end
  end
end

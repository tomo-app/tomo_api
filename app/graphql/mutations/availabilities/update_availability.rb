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
        availability
      end
    end
  end
end
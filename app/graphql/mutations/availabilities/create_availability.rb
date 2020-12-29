module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
      argument :params, Types::Input::AvailabilityInputType, required: true
      type Types::AvailabilityType

      def resolve(params:)
        availability_params = Hash params
        Availability.create(availability_params)
      end
    end
  end
end

module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
      argument :params, Types::Input::AvailabilityInputType, required: true
      type Types::AvailabilityType

      def resolve(params:)
        availability_params = Hash params
        return handle_no_languages_error if User.find(availability_params[:user_id]).user_languages.empty?

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

      def handle_no_languages_error
        GraphQL::ExecutionError.new('user must first have user languages in order to create availability')
      end
    end
  end
end

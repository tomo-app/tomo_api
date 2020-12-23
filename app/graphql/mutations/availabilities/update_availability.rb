module Mutations
  module Availabilities
    class UpdateAvailability < ::Mutations::BaseMutation
      # argument :params, Types::Input::UserInputType, required: false
      field :availability, Types::AvailabilityType, null: false
  
      def resolve(params:)
        availability_params = Hash params
        if availability_params[:id] != nil
            begin
            availability = Availability.find(availability_params[:id])
            availability.update(availability_params)

            { availability: availability }
            rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
                " #{e.record.errors.full_messages.join(', ')}")
            end
        else
            GraphQL::ExecutionError.new("You must provide an id to update an availability")
        end
      end
    end
  end
end
module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
        argument :params, Types::Input::UserInputType, required: true
    
        field :availability, Types::AvailabilityType, null: false
    
        def resolve(params:)
          availability_params = Hash params
            begin
              availability = Availability.create(availability_params)
      
              { availability: availability }
            rescue ActiveRecord::RecordInvalid => e
              GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
                " #{e.record.errors.full_messages.join(', ')}")
            end
        end
    end
  end
end
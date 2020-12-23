module Mutations
  module Availabilities
    class CreateAvailability < ::Mutations::BaseMutation
      argument :user_id, ID, required: true
      argument :start_date_time, String, required: true
      argument :end_date_time, String, required: true
      argument :status, Integer, required: false

      type Types::AvailabilityType

      def resolve(user_id:, start_date_time:, end_date_time:, status:)
        # begin
        require 'pry'; binding.pry
          Availability.create(attributes)
        #   { availability: availability }
        # rescue ActiveRecord::RecordInvalid => e
        #   GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        #     " #{e.record.errors.full_messages.join(', ')}")
      # end
      end
    end
  end
end
module Queries
    class GetAvailabilities < Queries::BaseQuery
  
      type Types::AvailabilityType, null: false
      argument :userId, ID, required: true
      argument :status, String, required: true

      def resolve(userId:, status:)
        ::Availability.where(user_id: userId, status: status).order(updated_at: :desc)
      end
    end
  end
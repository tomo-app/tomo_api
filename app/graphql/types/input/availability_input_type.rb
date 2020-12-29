module Types
  module Input
    class AvailabilityInputType < Types::BaseInputObject
      argument :user_id, ID, required: true
      argument :start_date_time, Integer, required: true
      argument :end_date_time, Integer, required: true
      argument :status, Integer, required: false
    end
  end
end

module Types
    class AvailabilityType < Types::BaseObject
      field :id, ID, null: false
      field :user_id, ID, null: false
      field :start_date_time, String, null: false
      field :end_date_time, String, null: false
      field :status, String, null: false
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
  
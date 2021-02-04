module Types
  class PairingType < Types::BaseObject
    field :id, ID, null: false
    field :user1_id, ID, null: false
    field :user2_id, ID, null: false
    field :date_time, Integer, null: false
    field :user1_cancelled, Boolean, null: false
    field :user2_cancelled, Boolean, null: false
    field :cancelled, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def cancelled
      self.object.cancelled?
    end
  end
end

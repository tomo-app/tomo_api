module Types
  class BlockedPairingType < Types::BaseObject
    field :id, ID, null: false
    field :blocking_user_id, ID, null: false
    field :blocked_user_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

module Types
  class TopicTranslationType < Types::BaseObject
    field :id, ID, null: false
    field :language_id, ID, null: false
    field :topic_id, ID, null: false
    field :translation, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end

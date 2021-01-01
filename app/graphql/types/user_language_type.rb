module Types
  class UserLanguageType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :language_id, ID, null: false
    field :fluency_level, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
  end
end

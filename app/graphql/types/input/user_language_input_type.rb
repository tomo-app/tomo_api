module Types
  module Input
    class UserLanguageInputType < Types::BaseInputObject
      argument :user_id, ID, required: true
      argument :language_id, ID, required: true
      argument :fluency_level, String, required: true
    end
  end
end

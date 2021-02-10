module Mutations
  module UserLanguages
    class CreateUserLanguage < ::Mutations::BaseMutation
      argument :params, Types::Input::UserLanguageInputType, required: true
      type Types::UserLanguageType

      def resolve(params:)
        UserLanguage.create(params.to_hash)
      end
    end
  end
end

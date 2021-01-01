module Mutations
  module UserLanguages
    class CreateUserLanguage < ::Mutations::BaseMutation
      argument :params, Types::Input::UserLanguageInputType, required: true
      type Types::UserLanguageType

      def resolve(params:)
        user_language_params = Hash params
        user_language_params[:fluency_level] = user_language_params[:fluency_level].to_i
        UserLanguage.create(user_language_params)
      end
    end
  end
end

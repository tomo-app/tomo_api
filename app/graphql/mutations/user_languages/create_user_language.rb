module Mutations
  module UserLanguages
    class CreateUserLanguage < ::Mutations::BaseMutation
      argument :params, Types::Input::UserLanguageInputType, required: true
      type Types::UserLanguageType

      def resolve(params:)
        user_lang_params = Hash params

        return handle_duplicate_user_lang if user_language_exists?(user_lang_params)

        UserLanguage.create(params.to_hash)
      end

      def user_language_exists?(params)
        !UserLanguage.where(user: params[:user_id], language: params[:language_id],
                            fluency_level: params[:fluency_level]).empty?
      end

      def handle_duplicate_user_lang
        GraphQL::ExecutionError.new('User already has this language and fluency level')
      end
    end
  end
end

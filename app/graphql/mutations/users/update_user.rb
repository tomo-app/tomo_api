module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :email, String, required: false
      argument :username, String, required: false
      argument :target_id, String, required: false
      argument :native_id, String, required: false

      type Types::UserType

      def resolve(arguments)
        user = User.find(arguments[:id])
        arguments.delete(:id)
        target_id = arguments.delete(:target_id)
        native_id = arguments.delete(:native_id)
        user.update(arguments)
        update_target(target_id, user) if target_id
        update_native(native_id, user) if native_id
        user
      end

      def update_target(target, user)
        user_language = user.user_languages.find_by(fluency_level: 'target')
        user_language.update(language_id: target) if user_language 
      end

      def update_native(native, user)
        user_language = user.user_languages.find_by(fluency_level: 'native')
        user_language.update(language_id: native) if user_language 
      end
    end
  end
end

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
        create_target(target_id, user) if target_id
        create_native(native_id, user) if native_id
        user
      end

      def create_target(target, user)
        user.user_languages.create(fluency_level: 1, language_id: target)
      end

      def create_native(native, user)
        user.user_languages.create(fluency_level: 0, language_id: native)
      end
    end
  end
end

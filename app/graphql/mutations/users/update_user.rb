module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :email, String, required: false
      argument :username, String, required: false
      argument :target_language_id, String, required: false
      argument :native_language_id, String, required: false

      type Types::UserType

      def resolve(arguments)
        user = User.find(arguments[:id])
        arguments.delete(:id)
        target_id = arguments.delete(:target_language_id)
        native_id = arguments.delete(:native_language_id)
        user.update(arguments)
        user.update_target(target_id, user) if target_id
        user.update_native(native_id, user) if native_id
        user
      end
    end
  end
end

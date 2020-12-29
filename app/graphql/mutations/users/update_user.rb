module Mutations
  module Users
    class UpdateUser < ::Mutations::BaseMutation
      argument :id, Integer, required: true
      argument :email, String, required: false
      argument :username, String, required: false

      type Types::UserType

      def resolve(arguments)
        user = User.find(arguments[:id])
        arguments.delete(:id)
        user.update(arguments)
        user
      end
    end
  end
end

module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :params, Types::Input::UserInputType, required: true
      type Types::UserType

      def resolve(params:)
        user_params = Hash params
        if user_params[:password] == user_params[:password_confirmation]
          user = User.create(user_params)
        else
          GraphQL::ExecutionError.new("passwords must match")
        end
      end
    end
  end
end

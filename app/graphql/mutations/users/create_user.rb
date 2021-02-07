module Mutations
  module Users
    class CreateUser < ::Mutations::BaseMutation
      argument :params, Types::Input::UserInputType, required: true
      type Types::UserType

      def resolve(params:)
        user_params = Hash params
        passwords_match = user_params[:password] == user_params[:password_confirmation]
        username_taken = User.exists?(username: user_params[:username])
        email_taken = User.exists?(email: user_params[:email])
        if passwords_match && !username_taken && !email_taken
          User.create(user_params)
        elsif !passwords_match
          GraphQL::ExecutionError.new('password and confirmation must match')
        elsif username_taken
          GraphQL::ExecutionError.new('That username aleady exists')
        elsif email_taken
          GraphQL::ExecutionError.new('That email is already taken')
        end
      end
    end
  end
end

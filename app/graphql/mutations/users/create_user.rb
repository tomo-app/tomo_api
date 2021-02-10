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
        else
          handle_errors(passwords_match, username_taken, email_taken)
        end
      end

      def handle_errors(passwords_match, username_taken, email_taken)
        if !passwords_match
          GraphQL::ExecutionError.new('password and confirmation must match')
        elsif username_taken
          GraphQL::ExecutionError.new('That username is already taken')
        elsif email_taken
          GraphQL::ExecutionError.new('That email is already taken')
        end
      end
    end
  end
end

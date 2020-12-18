module Mutations
    class UserSignUp < Mutations::BaseMutation
      argument :params, Types::Input::UserInputType, required: true
  
      field :user, Types::UserType, null: false
  
      def resolve(params:)
        user_params = Hash params
        if user_params[:password] == user_params[:password_confirmation]

          begin
            user = User.create!(user_params)
    
            { user: user }
          rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
              " #{e.record.errors.full_messages.join(', ')}")
          end
        else
          GraphQL::ExecutionError.new("passwords must match")
        end
      end
    end
  end
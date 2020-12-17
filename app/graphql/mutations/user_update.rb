module Mutations
    class UserUpdate < Mutations::BaseMutation
      argument :params, Types::Input::UserInputType, required: false
      field :user, Types::UserType, null: false
  
      def resolve(params:)
        user_params = Hash params
        if user_params[:id] != nil
            begin
            user = User.find(user_params[:id])
            user.update!(user_params)

            { user: user }
            rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
                " #{e.record.errors.full_messages.join(', ')}")
            end
        else
            GraphQL::ExecutionError.new("You must provide a user id to update a user")
        end
      end
    end
  end
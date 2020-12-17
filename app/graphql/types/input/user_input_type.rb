module Types
    module Input
      class UserInputType < Types::BaseInputObject
        argument :email, String, required: true
        argument :username, String, required: true
        argument :password, String, required: true
        argument :password_confirmation, String, required: true
      end
    end
  end
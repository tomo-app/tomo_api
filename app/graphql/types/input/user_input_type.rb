module Types
    module Input
      class UserInputType < Types::BaseInputObject
        # Users
        argument :email, String, required: false
        argument :username, String, required: false
        argument :password, String, required: false
        argument :password_confirmation, String, required: false
        argument :id, String, required: false
        # Availability
        argument :user_id, ID, required: false
        argument :start_date_time, String, required: false
        argument :end_date_time, String, required: false
        argument :status, Integer, required: false
      end
    end
  end
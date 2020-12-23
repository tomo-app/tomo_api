module Types
  class MutationType < Types::BaseObject
    field :user_sign_up, mutation: Mutations::Users::UserSignUp
    field :user_update, mutation: Mutations::Users::UserUpdate
    field :create_availability, mutation: Mutations::Availabilities::CreateAvailability
    field :update_availability, mutation: Mutations::Availabilities::UpdateAvailability
  end
end

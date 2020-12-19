module Types
  class MutationType < Types::BaseObject
    field :user_sign_up, mutation: Mutations::UserSignUp
    field :user_update, mutation: Mutations::UserUpdate
    field :create_availability, mutation: Mutations::CreateAvailability
    field :update_availability, mutation: Mutations::UpdateAvailability
  end
end

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :user_update, mutation: Mutations::Users::UserUpdate
    field :create_availability, mutation: Mutations::Availabilities::CreateAvailability
    field :update_availability, mutation: Mutations::Availabilities::UpdateAvailability
  end
end

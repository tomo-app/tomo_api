module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :create_availability, mutation: Mutations::Availabilities::CreateAvailability
    field :update_availability, mutation: Mutations::Availabilities::UpdateAvailability
  end
end

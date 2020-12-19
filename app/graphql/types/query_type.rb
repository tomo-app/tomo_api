module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :get_user, resolver: Queries::GetUser
    field :get_users, resolver: Queries::GetUsers
    field :get_availabilities, resolver: Queries::GetAvailabilities
  end
end

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :get_user, resolver: Queries::GetUser
    field :get_users, resolver: Queries::GetUsers
  end
end

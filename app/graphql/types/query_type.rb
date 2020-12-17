module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :query_users, resolver: Queries::QueryUsers
    field :query_user, resolver: Queries::QueryUser
  end
end

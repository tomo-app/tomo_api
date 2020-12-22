module Types
  class QueryType < Types::BaseObject
    field :get_users, [Types::UserType], null: false, description: 'Returns a list of users'

    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end

    field :get_availabilities, [Types::AvailabilityType], null: false, description: 'Returns all availabilities where user_id and status are as specified, and ordering them by start date(most future date first in list)' do
      argument :user_id, ID, required: true
      argument :status, String, required: true
    end

    def get_availabilities(user_id:, status:)
      ::Availability
      .where(user_id: user_id, status: status)
      .order(start_date_time: :asc)
    end

    def get_users
      User.all
    end

    def get_user(id:)
      User.find(id)
    end
  end
end

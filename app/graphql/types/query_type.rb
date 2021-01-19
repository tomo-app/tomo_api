module Types
  class QueryType < Types::BaseObject
    field :get_languages, [Types::LanguageType], null: false, description: 'Reurns a list of all languages'

    def get_languages
      Language.all
    end
    
    field :get_availabilities, [Types::AvailabilityType], null: false, description: 'Availabilities (sorted newest to oldest) by user_id and status' do
      argument :user_id, ID, required: true
      argument :status, String, required: true
    end

    def get_availabilities(user_id:, status:)
      ::Availability
        .where(user_id: user_id, status: status)
        .order(start_date_time: :asc)
    end

    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end
    
    def get_user(id:)
      User.find(id)
    end

    field :get_users, [Types::UserType], null: false, description: 'Returns a list of users'

    def get_users
      User.all
    end
  end
end

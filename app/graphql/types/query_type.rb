module Types
  class QueryType < Types::BaseObject
    # ----- languages -----
    field :get_languages, [Types::LanguageType], null: false, description: 'Reurns a list of all languages'

    def get_languages
      Language.all
    end
    
    # ----- availabilities -----
    field :get_availabilities, [Types::AvailabilityType], null: false, description: 'Availabilities (sorted newest to oldest) by user_id' do
      argument :user_id, ID, required: true
      argument :status, String, required: false
    end

    def get_availabilities(params)
      if params[:status]
        Availability.where(user_id: params[:user_id], status: params[:status])
        .order(start_date_time: :asc)
      else
        Availability.where(user_id: params[:user_id])
        .order(start_date_time: :asc)
      end
    end

    # ----- users -----
    field :get_user, Types::UserType, null: false, description: 'Returns a single user by id' do
      argument :id, ID, required: true
    end
    
    def get_user(id:)
      User.find(id)
    end

    field :authenticate, Types::UserType, null: false, description: 'Returns a users id if email/password are correct' do
      argument :email, String, required: true
      argument :password, String, required: true
    end
    
    def authenticate(email:, password:)
      user = User.find_by(email: email)
      if user
        return user if user.authenticate(password)
      end
    end

    # ----- pairings -----
    field :get_pairings, [Types::PairingType], null: false, description: 'Returns all pairings for a user by id' do
      argument :user_id, ID, required: true
    end

    def get_pairings(user_id:)
      Pairing.where(user1_id: user_id).or(Pairing.where(user2_id: user_id))
    end

    # ----- topics and translations -----
    field :get_topic_and_translations, Types::TopicType, null: false, description: 'Returns a random topic and any requested translations' do
      argument :language_ids, [ID], required: true
    end

    def get_topic_and_translations(language_ids:)
      raise GraphQL::ExecutionError, 'languageIds must contain two languages' if language_ids.size != 2
      topic = Topic.random
      context[:translations] = topic.translations_for_languages(language_ids)
      topic
    end
  end
end

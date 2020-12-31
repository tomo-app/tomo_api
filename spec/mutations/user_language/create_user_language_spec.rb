require 'rails_helper'

module Mutations
  module UserLanguages
    RSpec.describe CreateUserLanguage, type: :request do
      before :each do
        @user = create :user
        @language = create :language
      end

      def query(language_id:, user_id:, fluency_level:)
        <<~GQL
          mutation {
            createUserLanguage(input: { params: {
              languageId: "#{language_id}"
              userId: "#{user_id}"
              fluencyLevel: "#{fluency_level}"
            }}) {
              id
              languageId
              userId
              fluencyLevel
            }
          }
        GQL
      end

      it 'A user language can be created with fluency level of target' do
        post '/graphql', params: { query: query(user_id: @user.id, language_id: @language.id, fluency_level: 1) }
        
        json = JSON.parse(response.body)

        expect(json['data']['createUserLanguage']['id']).to_not eq(nil)

        expect(json['data']['createUserLanguage']['userId']).to be_a(String)
        expect(json['data']['createUserLanguage']['userId']).to eq(@user.id.to_s)

        expect(json['data']['createUserLanguage']['languageId']).to be_a(String)
        expect(json['data']['createUserLanguage']['languageId']).to eq(@language.id.to_s)

        expect(json['data']['createUserLanguage']['fluencyLevel']).to be_a(String)
        expect(json['data']['createUserLanguage']['fluencyLevel']).to eq("target")
      end

      it 'A user language can be created with fluency level of native' do        
        post '/graphql', params: { query: query(user_id: @user.id, language_id: @language.id, fluency_level: 0) }
        
        json = JSON.parse(response.body)

        expect(json['data']['createUserLanguage']['id']).to_not eq(nil)

        expect(json['data']['createUserLanguage']['userId']).to be_a(String)
        expect(json['data']['createUserLanguage']['userId']).to eq(@user.id.to_s)

        expect(json['data']['createUserLanguage']['languageId']).to be_a(String)
        expect(json['data']['createUserLanguage']['languageId']).to eq(@language.id.to_s)

        expect(json['data']['createUserLanguage']['fluencyLevel']).to be_a(String)
        expect(json['data']['createUserLanguage']['fluencyLevel']).to eq("native")
      end
    end
  end
end

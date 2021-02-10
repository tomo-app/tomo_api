require 'rails_helper'

module Mutations
  module UserLanguages
    RSpec.describe CreateUserLanguage, type: :request do
      before :each do
        @user = create :user
        @language = create :language
      end

      it 'A user language can be created with fluency level of target' do
        post graphql_path, params: { query: query(user_id: @user.id, language_id: @language.id, fluency_level: 1) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        user_lang = parsed[:data][:createUserLanguage]

        expect(user_lang[:id]).to_not eq(nil)

        expect(user_lang[:userId]).to be_a(String)
        expect(user_lang[:userId]).to eq(@user.id.to_s)

        expect(user_lang[:languageId]).to be_a(String)
        expect(user_lang[:languageId]).to eq(@language.id.to_s)

        expect(user_lang[:fluencyLevel]).to be_a(String)
        expect(user_lang[:fluencyLevel]).to eq('target')

        expect(UserLanguage.all.count).to eq(1)
      end

      it 'A user language can be created with fluency level of native' do        
        post graphql_path, params: { query: query(user_id: @user.id, language_id: @language.id, fluency_level: 0) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        user_lang = parsed[:data][:createUserLanguage]

        expect(user_lang[:id]).to_not eq(nil)

        expect(user_lang[:userId]).to be_a(String)
        expect(user_lang[:userId]).to eq(@user.id.to_s)

        expect(user_lang[:languageId]).to be_a(String)
        expect(user_lang[:languageId]).to eq(@language.id.to_s)

        expect(user_lang[:fluencyLevel]).to be_a(String)
        expect(user_lang[:fluencyLevel]).to eq('native')

        expect(UserLanguage.all.count).to eq(0)
      end

      it 'A user language cannot be created with user that doesnt exist' do        
        post graphql_path, params: { query: query(user_id: '234', language_id: @language.id, fluency_level: 0) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        
        expect(parsed[:errors][0][:message]).to eq('Cannot return null for non-nullable field UserLanguage.id')

        expect(UserLanguage.all.count).to eq(0)
      end

      it 'A user language cannot be created with language that doesnt exist' do        
        post graphql_path, params: { query: query(user_id: @user.id, language_id: '2387', fluency_level: 0) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:errors][0][:message]).to eq('Cannot return null for non-nullable field UserLanguage.id')

        expect(UserLanguage.all.count).to eq(0)
      end

      def query(language_id:, user_id:, fluency_level:)
        <<~GQL
          mutation {
            createUserLanguage(input: { params: {
              languageId: "#{language_id}"
              userId: "#{user_id}"
              fluencyLevel: #{fluency_level}
            }}) {
              id
              languageId
              userId
              fluencyLevel
            }
          }
        GQL
      end
    end
  end
end

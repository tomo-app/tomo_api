require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user, :with_availabilities)
      @language_one = create :language
      @language_two = create :language
      @target = create(:user_language, :target, user: @user_1, language: @language_one)
      @native = create(:user_language, :native, user: @user_1, language: @language_two)
    end

    def query(id:)
      <<~GQL
        query {
          getUser(
            id: #{id}
          ) {
            id
            username
            email
            availabilities {
              id
              userId
              startDateTime
              endDateTime
              status
              createdAt
              updatedAt
            }
            userLanguages {
              id
              userId
              languageId
              fluencyLevel
              createdAt
              updatedAt
            }
          }
        }
      GQL
    end

    describe 'user with availabilities' do
      it 'can get a single user without any availabilities' do
        post '/graphql', params: { query: query(id: @user_1.id) }

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:getUser][:id]).to eq(@user_1.id.to_s)
        expect(json[:data][:getUser][:username]).to eq(@user_1.username)
        expect(json[:data][:getUser][:email]).to eq(@user_1.email)
        expect(json[:data][:getUser][:availabilities]).to eq([])
      end

      it 'can get a single user with some availabilities' do
        post '/graphql', params: { query: query(id: @user_2.id) }

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:getUser][:id]).to eq(@user_2.id.to_s)
        expect(json[:data][:getUser][:username]).to eq(@user_2.username)
        expect(json[:data][:getUser][:email]).to eq(@user_2.email)
        expect(json[:data][:getUser][:availabilities].size).to eq(3)
        expect(json[:data][:getUser][:availabilities]).to eq(
          @user_2.availabilities.map do |avail|
            { 
              :id => avail.id.to_s,
              :userId => avail.user_id.to_s,
              :startDateTime => avail.start_date_time.to_s,
              :endDateTime => avail.end_date_time.to_s,
              :status => avail.status.to_s,
              :createdAt => avail.created_at.to_s,
              :updatedAt => avail.updated_at.to_s
            }
          end
        )
      end
    end

    describe 'user with user languages' do
      it 'can get a single user without any user languages' do
        post '/graphql', params: { query: query(id: @user_2.id) }

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:getUser][:id]).to eq(@user_2.id.to_s)
        expect(json[:data][:getUser][:username]).to eq(@user_2.username)
        expect(json[:data][:getUser][:email]).to eq(@user_2.email)
        expect(json[:data][:getUser][:userLanguages]).to eq([])
      end

      it 'can get a single user with some user_languages' do
        post '/graphql', params: { query: query(id: @user_1.id) }

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:getUser][:id]).to eq(@user_1.id.to_s)
        expect(json[:data][:getUser][:username]).to eq(@user_1.username)
        expect(json[:data][:getUser][:email]).to eq(@user_1.email)
        expect(json[:data][:getUser][:availabilities]).to eq([])

        expect(json[:data][:getUser][:userLanguages].size).to eq(2)
        expect(json[:data][:getUser][:userLanguages][0][:id]).to eq(@target.id.to_s)
        expect(json[:data][:getUser][:userLanguages][0][:userId]).to eq(@target.user_id.to_s)
        expect(json[:data][:getUser][:userLanguages][0][:languageId]).to eq(@target.language_id.to_s)
        expect(json[:data][:getUser][:userLanguages][0][:fluencyLevel]).to eq(@target.fluency_level)

        expect(json[:data][:getUser][:userLanguages][1][:id]).to eq(@native.id.to_s)
        expect(json[:data][:getUser][:userLanguages][1][:userId]).to eq(@native.user_id.to_s)
        expect(json[:data][:getUser][:userLanguages][1][:languageId]).to eq(@native.language_id.to_s)
        expect(json[:data][:getUser][:userLanguages][1][:fluencyLevel]).to eq(@native.fluency_level)
      end
    end
  end
end

require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user, :with_availabilities)
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
            }
          }
        }
      GQL
    end

    it 'can get a single user without any availabilities' do
      post '/graphql', params: { query: query(id: @user_1.id) }

      json = JSON.parse(response.body)

      expect(json['data']['getUser']['id']).to eq(@user_1.id.to_s)
      expect(json['data']['getUser']['username']).to eq(@user_1.username)
      expect(json['data']['getUser']['email']).to eq(@user_1.email)
      expect(json['data']['getUser']['availabilities']).to eq([])
    end

    it 'can get a single user with some availabilities' do
      post '/graphql', params: { query: query(id: @user_2.id) }

      json = JSON.parse(response.body)

      expect(json['data']['getUser']['id']).to eq(@user_2.id.to_s)
      expect(json['data']['getUser']['username']).to eq(@user_2.username)
      expect(json['data']['getUser']['email']).to eq(@user_2.email)
      expect(json['data']['getUser']['availabilities'].size).to eq(3)
      expect(json['data']['getUser']['availabilities']).to match_array(
        @user_2.availabilities.map do |avail|
          { 'id' => avail.id.to_s }
        end
      )
    end
  end
end

require 'rails_helper'

module Queries
  RSpec.describe Types::QueryType, type: :request do
    it 'can authenticate a user with correct credentials' do
      user = create(:user)
      post '/graphql', params: { query: query(email: user.email, password: user.password) }

      parsed = JSON.parse(response.body, symbolize_names: true)
      authentic_user = parsed[:data][:authenticate]

      expect(authentic_user[:id]).to eq(user.id.to_s)

      expect(authentic_user[:username]).to be_a(String)
      expect(authentic_user[:username]).to eq(user.username)

      expect(authentic_user[:email]).to be_a(String)
      expect(authentic_user[:email]).to eq(user.email)
    end

    it 'cannot authenticate a user with incorrect credentials' do
      user = create(:user)
      post '/graphql', params: { query: query(email: user.email, password: 'wrong') }

      parsed = JSON.parse(response.body, symbolize_names: true)

      expect(parsed[:errors][0][:message]).to eq('Incorrect email and/or password')
    end

    def query(email:, password:)
      <<~GQL
        query {
          authenticate(
            email: "#{email}"
            password: "#{password}"
          ) {
            id
            username
            email
          }
        }
      GQL
    end
  end
end

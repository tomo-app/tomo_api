require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      it 'A user can be created' do
        post '/graphql', params: { query: query(email: 'user@tomo.com', username: 'mari', password: '123', password_confirmation: '123') }

        parsed = JSON.parse(response.body, symbolize_names: true)
        user = parsed[:data][:createUser]

        expect(user[:id]).to_not eq(nil)

        expect(user[:username]).to be_a(String)
        expect(user[:username]).to eq('mari')

        expect(user[:email]).to be_a(String)
        expect(user[:email]).to eq('user@tomo.com')
      end

      def query(email:, username:, password:, password_confirmation:)
        <<~GQL
          mutation {
            createUser(input: { params: {
              email: "#{email}"
              username: "#{username}"
              password: "#{password}"
              passwordConfirmation: "#{password_confirmation}"
            }}) {
              id
              username
              email
            }
          }
        GQL
      end
    end
  end
end

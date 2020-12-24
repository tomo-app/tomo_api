require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
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

      it 'A user can be created' do
        post '/graphql', params: { query: query(email: "user@tomo.com", username: "mari", password: "123", password_confirmation: "123") }

        json = JSON.parse(response.body)

        expect(json['data']['createUser']['id']).to_not eq(nil)

        expect(json['data']['createUser']['username']).to be_a(String)
        expect(json['data']['createUser']['username']).to eq('mari')

        expect(json['data']['createUser']['email']).to be_a(String)
        expect(json['data']['createUser']['email']).to eq('user@tomo.com')
      end
    end
  end
end

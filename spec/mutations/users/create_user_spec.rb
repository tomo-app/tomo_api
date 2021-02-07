require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :request do
      it 'can create a user' do
        post '/graphql', params: { query: query(email: 'user@tomo.com', username: 'mari', password: '123', password_confirmation: '123') }

        parsed = JSON.parse(response.body, symbolize_names: true)
        user = parsed[:data][:createUser]

        expect(user[:id]).to_not eq(nil)

        expect(user[:username]).to be_a(String)
        expect(user[:username]).to eq('mari')

        expect(user[:email]).to be_a(String)
        expect(user[:email]).to eq('user@tomo.com')

        expect(User.all.count).to eq(1)
      end

      it 'cannot create a user if password does not match password confirmation' do
        post '/graphql', params: { query: query(email: 'user@tomo.com', username: 'mari', password: '123', password_confirmation: 'abc') }

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:errors][0][:message]).to eq('password and confirmation must match')
        
        expect(User.all.count).to eq(0)
      end

      it 'cannot create a user if the username exists' do
        create(:user, username: 'mari')
        post '/graphql', params: { query: query(email: 'user@tomo.com', username: 'mari', password: '123', password_confirmation: '123') }

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:errors][0][:message]).to eq('That username is already taken')
        
        expect(User.all.count).to eq(1)
      end

      it 'cannot create a user if the email is taken' do
        create(:user, email: 'user@tomo.com')
        post '/graphql', params: { query: query(email: 'user@tomo.com', username: 'mari', password: '123', password_confirmation: '123') }

        parsed = JSON.parse(response.body, symbolize_names: true)

        expect(parsed[:errors][0][:message]).to eq('That email is already taken')
        
        expect(User.all.count).to eq(1)
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

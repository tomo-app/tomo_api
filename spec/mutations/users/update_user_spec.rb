require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UpdateUser, type: :request do
      before :each do
        @existing_user = User.create!(email: 'JB@email.com', username: 'Jim', password: '1234')
      end

      it "A user can be updated" do
        query = <<~GQL
          mutation {
            updateUser(input: {
              id: #{@existing_user.id}
              email: "newme@email.com"
              username: "newme"
            }) {
              id
              username
              email
            }
          }
        GQL

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)

        expect(json['data']['updateUser']['id']).to_not eq(nil)
        expect(json['data']['updateUser']['email']).to eq('newme@email.com')
        expect(json['data']['updateUser']['username']).to eq('newme')
      end
    end
  end
end

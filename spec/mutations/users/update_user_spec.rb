require 'rails_helper'

module Mutations
  module Users
    RSpec.describe UpdateUser, type: :request do
      before :each do
        @existing_user = User.create!(email: 'JB@email.com', username: 'Jim', password: '1234')
        @target = create :language
        @native = create :language
        create(:user_language, :target, user: @existing_user, language: @target)
        create(:user_language, :native, user: @existing_user, language: @native)
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

      it "A user can update their target and native language" do
        query = <<~GQL
          mutation {
            updateUser(input: {
              id: #{@existing_user.id}
              targetId: "#{@target.id}"
              nativeId: "#{@native.id}"
            }) {
              id
              userLanguages{
                id
                userId
                languageId
                fluencyLevel
              }
            }
          }
        GQL

        post '/graphql', params: { query: query }

        json = JSON.parse(response.body)

        expect(json['data']['updateUser']['id']).to_not eq(nil)
        expect(json['data']['updateUser']['userLanguages'][0]['id']).to_not eq(nil)
        expect(json['data']['updateUser']['userLanguages'][0]['userId']).to eq(@existing_user.id.to_s)
        expect(json['data']['updateUser']['userLanguages'][0]['languageId']).to eq(@target.id.to_s)
        expect(json['data']['updateUser']['userLanguages'][0]['fluencyLevel']).to eq("target")

        expect(json['data']['updateUser']['userLanguages'][1]['id']).to_not eq(nil)
        expect(json['data']['updateUser']['userLanguages'][1]['userId']).to eq(@existing_user.id.to_s)
        expect(json['data']['updateUser']['userLanguages'][1]['languageId']).to eq(@native.id.to_s)
        expect(json['data']['updateUser']['userLanguages'][1]['fluencyLevel']).to eq("native")
      end
    end
  end
end

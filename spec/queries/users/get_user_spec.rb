require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType do
    before :each do
      User.create(id: '1', email: 'john@email.com', username: 'John', password: '1234')
      User.create(id: '2', email: 'jared@email.com', username: 'Jared', password: '1234')
      
      @get_user = <<-GRAPHQL
                                  query($id: ID!) {
                                      getUser(id: $id) {
                                          id
                                          username
                                          email
                                      }
                                  }
      GRAPHQL
    end

    describe 'Happy Paths' do
      it 'can get a single user by id' do
        user = TomoApiSchema.execute(@get_user, variables: { id: 1 })
        expect(user['data']['getUser']['id']).to eq('1')
        expect(user['data']['getUser']['username']).to eq('John')
        expect(user['data']['getUser']['email']).to eq('john@email.com')

        user = TomoApiSchema.execute(@get_user, variables: { id: 2 })
        expect(user['data']['getUser']['id']).to eq('2')
        expect(user['data']['getUser']['username']).to eq('Jared')
        expect(user['data']['getUser']['email']).to eq('jared@email.com')
      end
    end

    describe 'Sad Paths' do
      it 'cannot query a user when providing wrong parameters' do
        user = TomoApiSchema.execute(@get_user, variables: { username: 'John' })

        expect(user['errors'][0]['message']).to eq('Variable $id of type ID! was provided invalid value')
      end

      it 'cannot query a single user without providing id' do
        user = TomoApiSchema.execute(@get_user)

        expect(user['errors'][0]['message']).to eq('Variable $id of type ID! was provided invalid value')
      end
    end
  end
end

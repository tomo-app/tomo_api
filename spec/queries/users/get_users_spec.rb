require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType do
    before :each do
      User.create(id: '1', email: 'john@email.com', username: 'John', password: '1234')
      User.create(id: '2', email: 'jared@email.com', username: 'Jared', password: '1234')
                                  
      @get_users = <<-GRAPHQL
                                  query {
                                      getUsers {
                                          id
                                          username
                                          email
                                      }
                                  }
      GRAPHQL
    end

    describe 'Happy Paths' do
      it 'can get all users' do
        result = TomoApiSchema.execute(@get_users)
        users = User.all

        expect(result.dig('data', 'getUsers')).to match_array(
          users.map do |user|
            { 'id' => user.id.to_s, 'username' => user.username, 'email' => user.email }
          end
        )
      end
    end
  end
end

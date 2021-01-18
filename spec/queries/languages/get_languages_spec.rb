require 'rails_helper'
module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @language_one = create(:language)
      @language_two = create(:language)
      @language_three = create(:language)
    end

    def query
      <<~GQL
        query {
          getLanguages{
            id
            name
          }
        }
      GQL
    end

    it 'can get all languages' do
      post '/graphql', params: { query: query }

      json = JSON.parse(response.body)

      expect(json['data']['getLanguages'][0]['id']).to eq(@language_one.id.to_s)
      expect(json['data']['getLanguages'][0]['name']).to eq(@language_one.name)
      expect(json['data']['getLanguages'][1]['id']).to eq(@language_two.id.to_s)
      expect(json['data']['getLanguages'][1]['name']).to eq(@language_two.name)
      expect(json['data']['getLanguages'][2]['id']).to eq(@language_three.id.to_s)
      expect(json['data']['getLanguages'][2]['name']).to eq(@language_three.name)
    end
  end
end

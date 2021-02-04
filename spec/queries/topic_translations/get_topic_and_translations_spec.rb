require 'rails_helper'

module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @topic = create(:topic)
      @language_1 = create(:language)
      @language_2 = create(:language)
      @translation_1 = create(:topic_translation, topic: @topic, language: @language_1)
      @translation_2 = create(:topic_translation, topic: @topic, language: @language_2)
    end

    it 'can fetch a random topic and its translations' do
      post graphql_path, params: { query: query }

      parsed = JSON.parse(response.body, symbolize_names: true)
      translations = parsed[:data][:getTopicAndTranslations][:translations]

      expect(parsed[:data][:getTopicAndTranslations][:id]).to eq(@topic.id.to_s)
      expect(parsed[:data][:getTopicAndTranslations][:description]).to eq(@topic.description.to_s)

      expect(translations.size).to eq(2)

      translation_1 = translations.find { |translation| translation[:id] == @translation_1.id.to_s }
      expect(translation_1[:languageId]).to eq(@translation_1.language_id.to_s)
      expect(translation_1[:translation]).to eq(@translation_1.translation.to_s)

      translation_2 = translations.find { |translation| translation[:id] == @translation_2.id.to_s }
      expect(translation_2[:languageId]).to eq(@translation_2.language_id.to_s)
      expect(translation_2[:translation]).to eq(@translation_2.translation.to_s)
    end

    def query
      <<~GQL
        query {
          getTopicAndTranslations(
            languageIds: "[#{@language_1.id}, #{@language_2.id}]"
          ) {
            id
            description
            translations {
              id
              languageId
              topicId
              translation
              createdAt
              updatedAt
            }
            createdAt
            updatedAt
          }
        }
    GQL
    end
  end
end

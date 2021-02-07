require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'relationships' do
    it { should have_many :topic_translations }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
  end

  describe 'class methods' do
    describe 'random' do
      it 'gets a random topic' do
        create_list(:topic, 5)

        expect(Topic.random).to be_a(Topic)
      end
    end

    describe 'translations for languages' do
      it 'gets topic translations for specific languages' do
        topic = create(:topic)
        language_1 = create(:language)
        language_2 = create(:language)
        language_3 = create(:language)
        translation_1 = create(:topic_translation, topic: topic, language: language_1)
        translation_2 = create(:topic_translation, topic: topic, language: language_2)
        translation_2 = create(:topic_translation, topic: topic, language: language_3)

        translations = topic.translations_for_languages([language_1.id, language_2.id])
        lang_ids = translations.map {|translation| translation.language_id}

        expect(translations.size).to eq(2)
        expect(lang_ids.include?(language_1.id)).to eq(true)
        expect(lang_ids.include?(language_2.id)).to eq(true)
        expect(lang_ids.include?(language_3.id)).to eq(false)
      end
    end
  end
end
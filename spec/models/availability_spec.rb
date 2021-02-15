require 'rails_helper'

RSpec.describe Availability, type: :model do
  it { should validate_presence_of :start_date_time }
  it { should validate_presence_of :end_date_time }
  it { should validate_presence_of :status }

  describe 'model methods' do
    describe 'availabilities_to_pair' do 
      it 'can schedule and create a pairing' do
        japanese = create(:language)
        english = create(:language)
        japanese_learning_english = create(:user, id: 1)
        english_learning_japanese = create(:user, id: 2)
        english_learning_japanese_two = create(:user, id: 3)
        create(:user_language, :native, language: japanese, user: japanese_learning_english)
        create(:user_language, :target, language: english, user: japanese_learning_english)
        create(:user_language, :native, language: english, user: english_learning_japanese)
        create(:user_language, :target, language: japanese, user: english_learning_japanese)
        create(:user_language, :native, language: english, user: english_learning_japanese_two)
        create(:user_language, :target, language: japanese, user: english_learning_japanese_two)
        availability = japanese_learning_english.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 14, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        english_learning_japanese.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 45), status: 0)
        english_learning_japanese_two.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 45), status: 0)
        available_people = availability.availabilities_to_pair

        expect(available_people.size).to eq(1)
        expect(available_people.first.user_id).to eq(english_learning_japanese.id).or eq(english_learning_japanese_two.id)
      end

      it 'wont schedule with a blocked user' do
        japanese = create(:language)
        english = create(:language)
        japanese_learning_english = create(:user)
        english_learning_japanese = create(:user)
        create(:user_language, :native, language: japanese, user: japanese_learning_english)
        create(:user_language, :target, language: english, user: japanese_learning_english)
        create(:user_language, :native, language: english, user: english_learning_japanese)
        create(:user_language, :target, language: japanese, user: english_learning_japanese)
        BlockedPairing.create(blocking_user: japanese_learning_english, blocked_user: english_learning_japanese)
        availability = japanese_learning_english.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 14, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        english_learning_japanese.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        available_people = availability.availabilities_to_pair

        expect(available_people).to eq([])
      end
    end
  end
end

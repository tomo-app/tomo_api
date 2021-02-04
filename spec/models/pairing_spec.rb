require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should belong_to :user1 }
    it { should belong_to :user2 }
  end

  describe 'validations' do
    it { should validate_presence_of :date_time }
  end

  describe 'model methods' do
    before :each do
      japanese_learning_english = create(:user)
      english_learning_japanese = create(:user)
      @availability = japanese_learning_english.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 14, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
      @open_slot = english_learning_japanese.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
    end
    it 'create_pairing' do
      Pairing.create_pairing(@availability, [@open_slot])

      expect(Pairing.all.size).to eq(1)
    end

    it 'determine_time_of_pairing' do
      time = Pairing.determine_time_of_pairing(@availability, @open_slot)

      expect(time).to eq(@availability.start_date_time)
    end
  end
end

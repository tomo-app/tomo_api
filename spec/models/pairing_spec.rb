require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should belong_to :user1 }
    it { should belong_to :user2 }
  end

  describe 'validations' do
    it { should validate_presence_of :date_time }
  end

  describe 'instance methods' do
    describe 'cancelled?' do
      it 'determines whether or not pairing has been cancelled' do
        pairing_1 = create(:pairing, user1_cancelled: false, user2_cancelled: false )
        pairing_2 = create(:pairing, user1_cancelled: true, user2_cancelled: false )
        pairing_3 = create(:pairing, user1_cancelled: false, user2_cancelled: true )
        
        expect(pairing_1.cancelled?).to eq(false)
        expect(pairing_2.cancelled?).to eq(true)
        expect(pairing_3.cancelled?).to eq(true)
      end
    end
  end

  describe 'class methods' do
    describe 'create pairing' do
      it 'can create a pairing' do
        japanese_learning_english = create(:user)
        english_learning_japanese = create(:user)
        availability = japanese_learning_english.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 14, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        open_slot = english_learning_japanese.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        
        Pairing.create_pairing(availability, [open_slot])

        expect(Pairing.all.size).to eq(1)
      end
    end

    describe 'determine_time_of_pairing' do
      it 'can determine time of pairing' do
        japanese_learning_english = create(:user)
        english_learning_japanese = create(:user)
        availability = japanese_learning_english.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 14, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        open_slot = english_learning_japanese.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 30), status: 0)
        
        time = Pairing.determine_time_of_pairing(availability, open_slot)

        expect(time).to eq(availability.start_date_time)
      end
    end
  end
end

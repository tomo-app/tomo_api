require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should belong_to :user1 }
    it { should belong_to :user2 }
  end

  describe 'validations' do
    it { should validate_presence_of :date_time }
  end

  describe 'class methods' do
    describe 'cancelled?' do
      it 'determines whether or not pairing has been cancelled' do
        pairing_1 = create(:pairing, user1_cancelled?: false, user2_cancelled?: false )
        pairing_2 = create(:pairing, user1_cancelled?: true, user2_cancelled?: false )
        pairing_3 = create(:pairing, user1_cancelled?: false, user2_cancelled?: true )
        
        expect(pairing_1.cancelled?).to eq(false)
        expect(pairing_2.cancelled?).to eq(true)
        expect(pairing_3.cancelled?).to eq(true)
      end
    end
  end
end

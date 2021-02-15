require 'rails_helper'

RSpec.describe BlockedPairing, type: :model do
  describe 'relationships' do
    it { should belong_to :blocking_user }
    it { should belong_to :blocked_user }
  end

  describe 'class methods' do
    describe 'blocked_pairing_exists?' do 
      it 'can return whether or not a pairing has already been blocked' do
        blocking_user = create :user
        blocked_user = create :user
        BlockedPairing.create(blocking_user_id: blocking_user.id, blocked_user_id: blocked_user.id)

        expect(BlockedPairing.blocked_pairing_exists?(blocking_user.id, blocked_user.id)).to eq(true)
        expect(BlockedPairing.blocked_pairing_exists?(blocked_user.id, blocking_user.id)).to eq(false)
      end
    end
  end
end

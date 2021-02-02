require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :pairings }
    it { should have_many :blocked_pairings }
    it { should have_many :user_languages }
    it { should have_many(:languages).through(:user_languages) }
    it { should have_many :availabilities }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :password }
  end

  describe 'model methods' do
    it 'blocked_ids' do
      blocker = create(:user)
      blocked_one = create(:user)
      blocked_two = create(:user)
      blocked_three = create(:user)
      BlockedPairing.create(blocking_user: blocker, blocked_user: blocked_one)
      BlockedPairing.create(blocking_user: blocker, blocked_user: blocked_two)
      BlockedPairing.create(blocking_user: blocker, blocked_user: blocked_three)
      expect(blocker.blocked_ids.size).to eq(3)
    end
  end
end

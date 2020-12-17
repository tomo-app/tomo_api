require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_and_belong_to_many :pairings }
    it { should have_many :blocked_pairings }
    it { should have_many :user_languages }
    it { should have_many(:languages).through(:user_languages) }
  end

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :username }
    it { should validate_uniqueness_of :username }
    it { should validate_presence_of :password }
  end
end

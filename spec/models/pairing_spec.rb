require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should belong_to :user1 }
    it { should belong_to :user2 }
  end

  describe 'validations' do
    it { should validate_presence_of :date_time }
    it { should validate_presence_of :user1_cancelled? }
    it { should validate_presence_of :user2_cancelled? }
  end
end

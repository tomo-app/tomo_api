require 'rails_helper'

RSpec.describe Pairing, type: :model do
  describe 'relationships' do
    it { should have_and_belong_to_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of :date_time }
    it { should validate_presence_of :cancelled? }
  end
end

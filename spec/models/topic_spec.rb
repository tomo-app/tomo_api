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
  end
end
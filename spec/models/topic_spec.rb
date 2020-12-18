require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'relationships' do
    it { should have_many :topic_translations }
  end

  describe 'validations' do
    it { should validate_presence_of :description }
  end
end
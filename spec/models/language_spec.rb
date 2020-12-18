require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'relationships' do
    it { should have_many :user_languages }
    it { should have_many :topic_translations }
    it { should have_many(:users).through(:user_languages) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
end

require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'relationships' do
    it { should have_many :user_languages }
    it { should have_many :topic_translations }
    it { should have_many(:users).through(:user_languages) }
  end
end

require 'rails_helper'

RSpec.describe UserLanguage, type: :model do
  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :language }
  end
end

require 'rails_helper'

RSpec.describe TopicTranslation, type: :model do
  describe 'relationships' do
    it { should belong_to :topic }
    it { should belong_to :language }
  end

  describe 'validations' do
    it { should validate_presence_of :translation }
  end
end

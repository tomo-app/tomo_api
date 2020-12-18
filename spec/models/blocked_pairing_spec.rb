require 'rails_helper'

RSpec.describe BlockedPairing, type: :model do
  describe 'relationships' do
    it { should belong_to :blocking_user }
    it { should belong_to :blocked_user }
  end
end

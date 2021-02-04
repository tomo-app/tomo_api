require 'rails_helper'

module Mutations
  module BlockedPairings
    RSpec.describe CreateBlockedPairing, type: :request do
      before :each do
        @blocker = create :user
        @blocked = create :user
      end

      it 'A blocked pairing can be created' do
        post graphql_path, params: { query: query(blocking_user_id: @blocker.id, blocked_user_id: @blocked.id) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        blocked_pair = parsed[:data][:createBlockedPairing]

        expect(blocked_pair[:id]).to_not eq(nil)

        expect(blocked_pair[:blockingUserId]).to be_a(String)
        expect(blocked_pair[:blockingUserId]).to eq(@blocker.id.to_s)

        expect(blocked_pair[:blockedUserId]).to be_a(String)
        expect(blocked_pair[:blockedUserId]).to eq(@blocked.id.to_s)
      end

      def query(blocking_user_id:, blocked_user_id:)
        <<~GQL
          mutation {
            createBlockedPairing(input: { params: {
              blockingUserId: "#{blocking_user_id}"
              blockedUserId: "#{blocked_user_id}"
            }}) {
              id
              blockingUserId
              blockedUserId
            }
          }
        GQL
      end
    end
  end
end

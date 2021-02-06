require 'rails_helper'

module Mutations
  module Pairings
    RSpec.describe CancelPairing, type: :request do
      before :each do
        @user = create(:user)
        @pairing = create(:pairing, user1: @user, user1_cancelled: false, user2_cancelled: false)

      end

      it 'user can cancel pairing when designated as user_1 in pairing' do
        expect(@pairing.cancelled?).to eq(false)

        post graphql_path, params: { query: query(user_id: @user.id, pairing_id: @pairing.id) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        pairing = parsed[:data][:cancelPairing]

        expect(pairing[:id]).to eq(@pairing.id.to_s)
        expect(pairing[:user1Id]).to eq(@user.id.to_s)
        expect(pairing[:user1Cancelled]).to eq(true)
        expect(pairing[:user2Cancelled]).to eq(false)
        expect(pairing[:cancelled]).to eq(true)

        expect(Pairing.find(@pairing.id).cancelled?).to eq(true)
      end

      def query(user_id:, pairing_id:)
        <<~GQL
          mutation {
            cancelPairing(input: {
              id: "#{pairing_id}"
              userId: "#{user_id}"
            }) {
              id
              user1Id
              user2Id
              user1Cancelled
              user2Cancelled
              cancelled
            }
          }
        GQL
      end
    end
  end
end

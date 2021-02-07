require 'rails_helper'

module Mutations
  module Pairings
    RSpec.describe CancelPairing, type: :request do
      before :each do
        @user = create(:user)
        @pairing_1 = create(:pairing, user1: @user, user1_cancelled: false, user2_cancelled: false)
        @pairing_2 = create(:pairing, user2: @user, user1_cancelled: false, user2_cancelled: false)
      end

      it 'user can cancel pairing when designated as user_1 in pairing' do
        expect(@pairing_1.cancelled?).to eq(false)

        post graphql_path, params: { query: query(user_id: @user.id, pairing_id: @pairing_1.id) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        pairing = parsed[:data][:cancelPairing]

        expect(pairing[:id]).to eq(@pairing_1.id.to_s)
        expect(pairing[:user1Id]).to eq(@user.id.to_s)
        expect(pairing[:user1Cancelled]).to eq(true)
        expect(pairing[:user2Cancelled]).to eq(false)
        expect(pairing[:cancelled]).to eq(true)

        expect(Pairing.find(@pairing_1.id).cancelled?).to eq(true)
      end

      it 'user can cancel pairing when designated as user_2 in pairing' do
        expect(@pairing_2.cancelled?).to eq(false)

        post graphql_path, params: { query: query(user_id: @user.id, pairing_id: @pairing_2.id) }
        
        parsed = JSON.parse(response.body, symbolize_names: true)
        pairing = parsed[:data][:cancelPairing]

        expect(pairing[:id]).to eq(@pairing_2.id.to_s)
        expect(pairing[:user2Id]).to eq(@user.id.to_s)
        expect(pairing[:user1Cancelled]).to eq(false)
        expect(pairing[:user2Cancelled]).to eq(true)
        expect(pairing[:cancelled]).to eq(true)

        expect(Pairing.find(@pairing_2.id).cancelled?).to eq(true)
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

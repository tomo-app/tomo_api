require 'rails_helper'

module Queries
  RSpec.describe Types::QueryType, type: :request do
    before :each do
      @user = create(:user)
      @affirmed_pairing = create(:pairing, user1: @user, user1_cancelled: false, user2_cancelled: false)
      @user1_cancelled_pairing = create(:pairing, user2: @user, user1_cancelled: true, user2_cancelled: false)
      @user2_cancelled_pairing = create(:pairing, user1: @user, user1_cancelled: false, user2_cancelled: true)
    end

    it "can get all of a user's pairings" do
      post graphql_path, params: { query: query }

      parsed = JSON.parse(response.body, symbolize_names: true)
      pairings = parsed[:data][:getPairings]

      affirmed_pairing = pairings.find { |pair| pair[:id] == @affirmed_pairing.id.to_s }
      cancelled_1 = pairings.find { |pair| pair[:id] == @user1_cancelled_pairing.id.to_s }
      cancelled_2 = pairings.find { |pair| pair[:id] == @user2_cancelled_pairing.id.to_s }

      expect(pairings.size).to eq(3)

      expect(affirmed_pairing[:user1Id]).to eq(@user.id.to_s)
      expect(affirmed_pairing[:user2Id]).to_not be(nil)
      expect(affirmed_pairing[:cancelled]).to eq(false)

      expect(cancelled_1[:user1Id]).to_not be(nil)
      expect(cancelled_1[:user2Id]).to eq(@user.id.to_s)
      expect(cancelled_1[:cancelled]).to eq(true)

      expect(cancelled_2[:user1Id]).to eq(@user.id.to_s)
      expect(cancelled_2[:user2Id]).to_not be(nil)
      expect(cancelled_2[:cancelled]).to eq(true)
    end

    def query
      <<~GQL
        query {
          getPairings(
            userId: "#{@user.id}"
          ) {
            id
            cancelled
            user1Id
            user2Id
            dateTime
            user1Cancelled
            user2Cancelled
            createdAt
            updatedAt
          }
        }
    GQL
    end
  end
end

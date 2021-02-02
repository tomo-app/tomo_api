require 'rails_helper'

module Mutations
  module Availabilities
    RSpec.describe CreateAvailability, type: :request do
      before :each do
        @user = User.create(email: 'JB@email.com', username: 'Jim Bobby', password: '1234')
        @start_dt = DateTime.new(2021, 1, 1, 9, 30).to_i
        @end_dt = DateTime.new(2021, 1, 1, 12, 30).to_i
        @language1 = create(:language)
        @language2 = create(:language)
        create(:user_language, :native, language: @language1, user: @user)
        create(:user_language, :target, language: @language2, user: @user)
      end

      def query(status:)
        <<~GQL
          mutation {
            createAvailability(input: { params: {
              userId: #{@user.id}
              startDateTime: #{@start_dt}
              endDateTime: #{@end_dt}
              status: #{status}
            }}) {
              id
              userId
              startDateTime
              endDateTime
              status
            }
          }
        GQL
      end

      it 'An availability can be created with default status of open' do
        post '/graphql', params: { query:
          "mutation {
          createAvailability(input: { params: {
            userId: #{@user.id}
            startDateTime: 1609489800
            endDateTime: 1609504200
          }}) {
            id
            userId
            startDateTime
            endDateTime
            status
          }
        }" }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:createAvailability][:id]).to_not be(nil)
        expect(json[:data][:createAvailability][:userId]).to eq(@user.id.to_s)
        expect(json[:data][:createAvailability][:startDateTime]).to eq('1609489800')
        expect(json[:data][:createAvailability][:endDateTime]).to eq('1609504200')
        expect(json[:data][:createAvailability][:status]).to eq('open')
      end

      it 'An availability can be created as fulfilled' do
        post '/graphql', params: { query: query(status: 1) }
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:createAvailability][:id]).to_not be(nil)
        expect(json[:data][:createAvailability][:userId]).to eq(@user.id.to_s)
        expect(json[:data][:createAvailability][:startDateTime]).to eq(@start_dt.to_s)
        expect(json[:data][:createAvailability][:endDateTime]).to eq(@end_dt.to_s)
        expect(json[:data][:createAvailability][:status]).to eq('fulfilled')
      end

      it 'An availability can be created as cancelled' do
        post '/graphql', params: { query: query(status: 2) }
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:createAvailability][:id]).to_not be(nil)
        expect(json[:data][:createAvailability][:userId]).to eq(@user.id.to_s)
        expect(json[:data][:createAvailability][:startDateTime]).to eq(@start_dt.to_s)
        expect(json[:data][:createAvailability][:endDateTime]).to eq(@end_dt.to_s)
        expect(json[:data][:createAvailability][:status]).to eq('cancelled')
      end

      it 'when an availability is created it tries to pair the user' do
        japanese_learning_english = create(:user, id: 1)
        start_dt = DateTime.new(2021, 1, 1, 14, 30).to_i
        end_dt = DateTime.new(2021, 1, 1, 15, 30).to_i
        english_learning_japanese = create(:user, id: 2)
        english_learning_japanese_two = create(:user, id: 3)
        create(:user_language, :native, language: @language1, user: japanese_learning_english)
        create(:user_language, :target, language: @language2, user: japanese_learning_english)
        create(:user_language, :native, language: @language2, user: english_learning_japanese)
        create(:user_language, :target, language: @language1, user: english_learning_japanese)
        create(:user_language, :native, language: @language2, user: english_learning_japanese_two)
        create(:user_language, :target, language: @language1, user: english_learning_japanese_two)
        english_learning_japanese.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 45), status: 0)
        english_learning_japanese_two.availabilities.create(start_date_time: DateTime.new(2021, 1, 1, 13, 30), end_date_time: DateTime.new(2021, 1, 1, 15, 45), status: 0)

        post '/graphql', params: { query:
          "mutation {
          createAvailability(input: { params: {
            userId: #{japanese_learning_english.id}
            startDateTime: #{start_dt}
            endDateTime: #{end_dt}
          }}) {
            id
            userId
            startDateTime
            endDateTime
            status
          }
        }" }

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:createAvailability][:id]).to_not be(nil)
        expect(json[:data][:createAvailability][:userId]).to eq(japanese_learning_english.id.to_s)
        expect(json[:data][:createAvailability][:startDateTime]).to eq(start_dt.to_s)
        expect(json[:data][:createAvailability][:endDateTime]).to eq(end_dt.to_s)
        expect(json[:data][:createAvailability][:status]).to eq('fulfilled')
        
        expect(Pairing.all.size).to eq(1)
      end
    end
  end
end

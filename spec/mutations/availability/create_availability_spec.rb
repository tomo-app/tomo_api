require 'rails_helper'

module Mutations
  module Availabilities
    RSpec.describe CreateAvailability, type: :request do
      before :each do
        @user = User.create(email: 'JB@email.com', username: 'Jim Bobby', password: '1234')
        @start_dt = DateTime.new(2021, 1, 1, 9, 30).to_i
        @end_dt = DateTime.new(2021, 1, 1, 12, 30).to_i
      end

      it 'An availability can be created with default status of open' do
        post graphql_path, params: { query:
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

        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:createAvailability]

        expect(avail[:id]).to_not be(nil)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq('1609489800')
        expect(avail[:endDateTime]).to eq('1609504200')
        expect(avail[:status]).to eq('open')
      end

      it 'An availability can be created as fulfilled' do
        post graphql_path, params: { query: query(status: 1) }
        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:createAvailability]

        expect(avail[:id]).to_not be(nil)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq(@start_dt.to_s)
        expect(avail[:endDateTime]).to eq(@end_dt.to_s)
        expect(avail[:status]).to eq('fulfilled')
      end

      it 'An availability can be created as cancelled' do
        post graphql_path, params: { query: query(status: 2) }
        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:createAvailability]

        expect(avail[:id]).to_not be(nil)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq(@start_dt.to_s)
        expect(avail[:endDateTime]).to eq(@end_dt.to_s)
        expect(avail[:status]).to eq('cancelled')
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
    end
  end
end

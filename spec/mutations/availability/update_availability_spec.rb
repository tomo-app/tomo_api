require 'rails_helper'

module Mutations
  module Availabilities
    RSpec.describe UpdateAvailability, type: :request do
      before :each do
        @user = User.create(email: 'JB@email.com', username: 'Jim Bobby', password: '1234')
        @start_dt = DateTime.new(2021, 1, 1, 9, 30).to_i
        @end_dt = DateTime.new(2021, 1, 1, 12, 30).to_i
        @availability = Availability.create!(user_id: @user.id, start_date_time: @start_dt, end_date_time: @end_dt)
      end

      it "An availability can be updated as cancelled" do
        post graphql_path, params: { query:
          "mutation {
            updateAvailability(input: {
              id: #{@availability.id.to_s}
              status: 2
            }) {
              id
              userId
              startDateTime
              endDateTime
              status
            }
          }" }

        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:updateAvailability]

        expect(avail[:id]).to eq(@availability.id.to_s)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq(@start_dt.to_s)
        expect(avail[:endDateTime]).to eq(@end_dt.to_s)
        expect(avail[:status]).to eq('cancelled')
      end

      it "An availability start date time can be updated" do
        post graphql_path, params: { query:
          "mutation {
            updateAvailability(input: {
              id: #{@availability.id.to_s}
              startDateTime: 1612355400
            }) {
              id
              userId
              startDateTime
              endDateTime
              status
            }
          }" }

        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:updateAvailability]

        expect(avail[:id]).to eq(@availability.id.to_s)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq(1612355400.to_s)
        expect(avail[:endDateTime]).to eq(@end_dt.to_s)
        expect(avail[:status]).to eq('open')
      end

      it "An availability end date time can be updated" do
        post graphql_path, params: { query: 
          "mutation {
            updateAvailability(input: {
              id: #{@availability.id.to_s}
              endDateTime: 1612328400
            }) {
              id
              userId
              startDateTime
              endDateTime
              status
            }
          }" }

        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:updateAvailability]

        expect(avail[:id]).to eq(@availability.id.to_s)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq(@start_dt.to_s)
        expect(avail[:endDateTime]).to eq(1612328400.to_s)
        expect(avail[:status]).to eq('open')
      end

      it "An availability start and end date time can be updated" do
        post graphql_path, params: { query: 
          "mutation {
            updateAvailability(input: {
              id: #{@availability.id.to_s}
              startDateTime: 1612324800
              endDateTime: 1612328400
            }) {
              id
              userId
              startDateTime
              endDateTime
              status
            }
          }" }

        parsed = JSON.parse(response.body, symbolize_names: true)
        avail = parsed[:data][:updateAvailability]

        expect(avail[:id]).to eq(@availability.id.to_s)
        expect(avail[:userId]).to eq(@user.id.to_s)
        expect(avail[:startDateTime]).to eq(1612324800.to_s)
        expect(avail[:endDateTime]).to eq(1612328400.to_s)
        expect(avail[:status]).to eq('open')
      end
    end
  end
end
require 'rails_helper'

RSpec.describe Types::QueryType, type: :request do
  describe 'get availabilities' do
    before :each do
      @user = User.create(id: "1", email:"john@email.com", username: "John", password:"1234")
      @start_dt_1 = DateTime.new(2020, 12, 25, 1, 30).to_i
      @end_dt_1 = DateTime.new(2020, 12, 25, 3, 30).to_i
      @start_dt_2 = DateTime.new(2020, 12, 27, 1, 30).to_i
      @end_dt_2 = DateTime.new(2020, 12, 27, 3, 30).to_i
      @open = Availability.create(user: @user, start_date_time: @start_dt_1, end_date_time: @end_dt_1, status: 0 )
      @open_2 = Availability.create(user: @user, start_date_time: @start_dt_2, end_date_time: @end_dt_2, status: 0 )
      @fulfilled = Availability.create(user: @user, start_date_time: @start_dt_1, end_date_time: @end_dt_1, status: 1 )
      @cancelled = Availability.create(user: @user, start_date_time: @start_dt_1, end_date_time: @end_dt_1, status: 2 )
    end

    it "can query user's availabilities by status open and order by date asc" do
      post graphql_path, params: { query: query(user_id: @user.id, status: 'open') }

      result = JSON.parse(response.body, symbolize_names: true)
      avail_1 = result[:data][:getAvailabilities][0]
      avail_2 = result[:data][:getAvailabilities][1]

      expect(avail_1[:id]).to eq(@open.id.to_s)
      expect(avail_1[:userId]).to eq(@user.id.to_s)
      expect(avail_1[:startDateTime]).to eq(@start_dt_1.to_s)
      expect(avail_1[:endDateTime]).to eq(@end_dt_1.to_s)
      expect(avail_1[:status]).to eq('open')

      expect(avail_2[:id]).to eq(@open_2.id.to_s)
      expect(avail_2[:userId]).to eq(@user.id.to_s)
      expect(avail_2[:startDateTime]).to eq(@start_dt_2.to_s)
      expect(avail_2[:endDateTime]).to eq(@end_dt_2.to_s)
      expect(avail_2[:status]).to eq('open')
    end

    it "can query user's availabilities by status fulfilled" do
      post graphql_path, params: { query: query(user_id: @user.id, status: 'fulfilled') }
      result = JSON.parse(response.body, symbolize_names: true)
      avail_1 = result[:data][:getAvailabilities][0]

      expect(avail_1[:id]).to eq(@fulfilled.id.to_s)
      expect(avail_1[:userId]).to eq(@user.id.to_s)
      expect(avail_1[:startDateTime]).to eq(@start_dt_1.to_s)
      expect(avail_1[:endDateTime]).to eq(@end_dt_1.to_s)
      expect(avail_1[:status]).to eq('fulfilled')
    end

    it "can query user's availabilities by status cancelled" do
      post graphql_path, params: { query: query(user_id: @user.id, status: 'cancelled') }
      result = JSON.parse(response.body, symbolize_names: true)
      avail_1 = result[:data][:getAvailabilities][0]

      expect(avail_1[:id]).to eq(@cancelled.id.to_s)
      expect(avail_1[:userId]).to eq(@user.id.to_s)
      expect(avail_1[:startDateTime]).to eq(@start_dt_1.to_s)
      expect(avail_1[:endDateTime]).to eq(@end_dt_1.to_s)
      expect(avail_1[:status]).to eq('cancelled')
    end

    def query(user_id:, status:)
      <<~GQL
        query {
          getAvailabilities(
            userId: "#{user_id}"
            status: "#{status}"
          ) {
            userId
            id
            startDateTime
            endDateTime
            status
            createdAt
            updatedAt
          }
        }
      GQL
    end
  end
end

require "rails_helper"
module Types
    RSpec.describe ::Availability, type: :request do 
        before :each do
            @user = User.create(id: "1", email:"john@email.com", username: "John", password:"1234")
            @start_dt_1 = DateTime.new(2020, 12, 25, 1, 30).to_i
            @end_dt_1 = DateTime.new(2020, 12, 25, 3, 30).to_i
            @start_dt_2 = DateTime.new(2020, 12, 27, 1, 30).to_i
            @end_dt_2 = DateTime.new(2020, 12, 27, 3, 30).to_i
            @open = ::Availability.create(user: @user, start_date_time: @start_dt_1, end_date_time: @end_dt_1, status: 0 )
            @open2 = ::Availability.create(user: @user, start_date_time: @start_dt_2, end_date_time: @end_dt_2, status: 0 )
            @fulfilled = ::Availability.create(user: @user, start_date_time: @start_dt_1, end_date_time: @end_dt_1, status: 1 )
            @cancelled = ::Availability.create(user: @user, start_date_time: @start_dt_1, end_date_time: @end_dt_1, status: 2 )
            @get_availabilities = <<-GRAPHQL
            query($userId: ID!, $status: String!) {
                getAvailabilities(userId: $userId, status: $status) {
                    userId
                    startDateTime
                    endDateTime
                    status
                }
            }
            GRAPHQL
        end

        describe "Happy Paths -" do
            it "can query a users availabilities by status open, and ordered by date asc" do
                availabilities = TomoApiSchema.execute(@get_availabilities, variables: { userId: @user.id, status: "open" } )

                expect(availabilities["data"]["getAvailabilities"][0]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][0]["startDateTime"]).to eq(@start_dt_1.to_s)
                expect(availabilities["data"]["getAvailabilities"][0]["endDateTime"]).to eq(@end_dt_1.to_s)
                expect(availabilities["data"]["getAvailabilities"][0]["status"]).to eq("open")

                expect(availabilities["data"]["getAvailabilities"][1]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][1]["startDateTime"]).to eq(@start_dt_2.to_s)
                expect(availabilities["data"]["getAvailabilities"][1]["endDateTime"]).to eq(@end_dt_2.to_s)
                expect(availabilities["data"]["getAvailabilities"][1]["status"]).to eq("open")
            end

            it "can query a users availabilities by status fulfilled" do
                availabilities = TomoApiSchema.execute(@get_availabilities, variables: { userId: @user.id, status: "fulfilled" } )

                expect(availabilities["data"]["getAvailabilities"][0]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][0]["startDateTime"]).to eq(@start_dt_1.to_s)
                expect(availabilities["data"]["getAvailabilities"][0]["endDateTime"]).to eq(@end_dt_1.to_s)
                expect(availabilities["data"]["getAvailabilities"][0]["status"]).to eq("fulfilled")
            end

            it "can query a users availabilities by status cancelled" do
                availabilities = TomoApiSchema.execute(@get_availabilities, variables: { userId: @user.id, status: "cancelled" } )

                expect(availabilities["data"]["getAvailabilities"][0]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][0]["startDateTime"]).to eq(@start_dt_1.to_s)
                expect(availabilities["data"]["getAvailabilities"][0]["endDateTime"]).to eq(@end_dt_1.to_s)
                expect(availabilities["data"]["getAvailabilities"][0]["status"]).to eq("cancelled")
            end
        end
    end
end
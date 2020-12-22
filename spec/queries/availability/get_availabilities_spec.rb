require "rails_helper"
module Types
    RSpec.describe ::Availability, type: :request do 
        before :each do 
            @user = User.create(id: "1", email:"john@email.com", username: "John", password:"1234")
            @dt = DateTime.new.to_i.to_s
            @open = ::Availability.create(user: @user, start_date_time: @dt, end_date_time: @dt, status: 0 )
            @open2 = ::Availability.create(user: @user, start_date_time: DateTime.new(2001,2,3).to_i.to_s, end_date_time: @dt, status: 0 )
            @fulfilled = ::Availability.create(user: @user, start_date_time: @dt, end_date_time: @dt, status: 1 )
            @cancelled = ::Availability.create(user: @user, start_date_time: @dt, end_date_time: @dt, status: 2 )
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
                expect(availabilities["data"]["getAvailabilities"][0]["startDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][0]["endDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][0]["status"]).to eq("open")

                expect(availabilities["data"]["getAvailabilities"][1]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][1]["startDateTime"]).to eq(DateTime.new(2001,2,3).to_i.to_s)
                expect(availabilities["data"]["getAvailabilities"][1]["endDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][1]["status"]).to eq("open")
            end

            it "can query a users availabilities by status fulfilled" do
                availabilities = TomoApiSchema.execute(@get_availabilities, variables: { userId: @user.id, status: "fulfilled" } )

                expect(availabilities["data"]["getAvailabilities"][0]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][0]["startDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][0]["endDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][0]["status"]).to eq("fulfilled")
            end

            it "can query a users availabilities by status cancelled" do
                availabilities = TomoApiSchema.execute(@get_availabilities, variables: { userId: @user.id, status: "cancelled" } )

                expect(availabilities["data"]["getAvailabilities"][0]["userId"]).to eq("1")
                expect(availabilities["data"]["getAvailabilities"][0]["startDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][0]["endDateTime"]).to eq(@dt)
                expect(availabilities["data"]["getAvailabilities"][0]["status"]).to eq("cancelled")
            end
        end
    end
end
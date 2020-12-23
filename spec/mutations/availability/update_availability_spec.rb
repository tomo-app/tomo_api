require 'rails_helper'

module Mutations
    module Availabilities
        RSpec.describe UpdateAvailability, type: :request do
            before :each do
                @dt = DateTime.new.to_i.to_s
                @user = User.create(email: "JB@email.com", username: "Jim Bobby", password: "1234")
                @availability = Availability.create!(user_id: @user.id.to_s, start_date_time: DateTime.new.to_s, end_date_time: DateTime.new.to_s)
                @updateAvailability = <<-GRAPHQL
                                mutation($input: UpdateAvailabilityInput!) {
                                    updateAvailability(input: $input) {
                                        availability {
                                            id
                                            userId
                                            startDateTime
                                            endDateTime
                                            status
                                        }
                                    }
                                }
                            GRAPHQL
            end
            describe "Happy Paths - " do
                it "An availability can be updated as cancelled" do
                    updated_availability = TomoApiSchema.execute(@updateAvailability, variables: { input: { params: { id: @availability.id.to_s, startDateTime: @dt, endDateTime: @dt, status: 2 } }})

                    expect(updated_availability['data']['updateAvailability']["availability"]["userId"]).to eq(@user.id.to_s)
                    expect(updated_availability['data']['updateAvailability']["availability"]["startDateTime"]).to eq(@dt)
                    expect(updated_availability['data']['updateAvailability']["availability"]["endDateTime"]).to eq(@dt)
                    expect(updated_availability['data']['updateAvailability']["availability"]["status"]).to eq("cancelled")
                end

                it "An availability can be updated as fulfilled" do
                    updated_availability = TomoApiSchema.execute(@updateAvailability, variables: { input: { params: { id: @availability.id.to_s, startDateTime: @dt, endDateTime: @dt, status: 1 } }})

                    expect(updated_availability['data']['updateAvailability']["availability"]["userId"]).to eq(@user.id.to_s)
                    expect(updated_availability['data']['updateAvailability']["availability"]["startDateTime"]).to eq(@dt)
                    expect(updated_availability['data']['updateAvailability']["availability"]["endDateTime"]).to eq(@dt)
                    expect(updated_availability['data']['updateAvailability']["availability"]["status"]).to eq("fulfilled")
                end

                it "An availability can be updated as open" do
                    updated_availability = TomoApiSchema.execute(@updateAvailability, variables: { input: { params: { id: @availability.id.to_s, startDateTime: @dt, endDateTime: @dt, status: 0 } }})

                    expect(updated_availability['data']['updateAvailability']["availability"]["userId"]).to eq(@user.id.to_s)
                    expect(updated_availability['data']['updateAvailability']["availability"]["startDateTime"]).to eq(@dt)
                    expect(updated_availability['data']['updateAvailability']["availability"]["endDateTime"]).to eq(@dt)
                    expect(updated_availability['data']['updateAvailability']["availability"]["status"]).to eq("open")
                end
            end

            describe "Sad Paths - " do
                it "An availability cannot be updated without an availability id" do
                   non_updated_availability = TomoApiSchema.execute(@updateAvailability, variables: { input: { params: { startDateTime: @dt, endDateTime: @dt, status: 4 } }})

                    expect(non_updated_availability['errors'][0]['message']).to eq("You must provide an id to update an availability")
                end

                it "An availability cannot be updated with an unknown attribute" do
                   non_updated_availability = TomoApiSchema.execute(@updateAvailability, variables: { input: { params: { start: @dt, end: @dt, status: 4 } }})

                    expect(non_updated_availability['errors'][0]['message']).to eq("Variable $input of type UpdateAvailabilityInput! was provided invalid value for params.start (Field is not defined on UserInput), params.end (Field is not defined on UserInput)")
                end
            end
        end
    end
end
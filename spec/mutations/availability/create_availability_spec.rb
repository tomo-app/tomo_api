require 'rails_helper'

module Mutations
    module Availability
        RSpec.describe CreateAvailability, type: :request do
            before :each do
                @dt = DateTime.new.to_i.to_s
                @user = User.create(email: "JB@email.com", username: "Jim Bobby", password: "1234")
                @availabilityCreate = <<-GRAPHQL
                                mutation($input: CreateAvailabilityInput!) {
                                    createAvailability(input: $input) {
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
                it "An availability can be created with default status of open" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, endDateTime: @dt, userId: @user.id} }})

                    expect(availability['data']['createAvailability']["availability"]["id"]).to_not be(nil)
                    expect(availability['data']['createAvailability']["availability"]["userId"]).to eq(@user.id.to_s)
                    expect(availability['data']['createAvailability']["availability"]["startDateTime"]).to eq(@dt)
                    expect(availability['data']['createAvailability']["availability"]["endDateTime"]).to eq(@dt)
                    expect(availability['data']['createAvailability']["availability"]["status"]).to eq("open")
                end

                it "An availability can be created as fulfilled" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, endDateTime: @dt, userId: @user.id, status: 1 } }})

                    expect(availability['data']['createAvailability']["availability"]["id"]).to_not be(nil)
                    expect(availability['data']['createAvailability']["availability"]["userId"]).to eq(@user.id.to_s)
                    expect(availability['data']['createAvailability']["availability"]["startDateTime"]).to eq(@dt)
                    expect(availability['data']['createAvailability']["availability"]["endDateTime"]).to eq(@dt)
                    expect(availability['data']['createAvailability']["availability"]["status"]).to eq("fulfilled")
                end

                it "An availability can be created as cancelled" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, endDateTime: @dt, userId: @user.id, status: 2 } }})

                    expect(availability['data']['createAvailability']["availability"]["id"]).to_not be(nil)
                    expect(availability['data']['createAvailability']["availability"]["userId"]).to eq(@user.id.to_s)
                    expect(availability['data']['createAvailability']["availability"]["startDateTime"]).to eq(@dt)
                    expect(availability['data']['createAvailability']["availability"]["endDateTime"]).to eq(@dt)
                    expect(availability['data']['createAvailability']["availability"]["status"]).to eq("cancelled")
                end
            end

            describe "Sad Paths - " do
                it "An availability cannot be created without userId" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, endDateTime: @dt } }})

                    expect(availability['errors'][0]['message']).to eq("Invalid attributes for Availability: User must exist")
                end

                it "An availability cannot be created without a start date" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { endDateTime: @dt, userId: @user.id } }})

                    expect(availability['errors'][0]['message']).to eq("Invalid attributes for Availability: Start date time can't be blank")
                end

                it "An availability cannot be created without an end date" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, userId: @user.id } }})

                    expect(availability['errors'][0]['message']).to eq("Invalid attributes for Availability: End date time can't be blank")
                end

                it "An availability cannot be created with unknown attributes" do
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { start: @dt, end: @dt, userId: @user.id } }})

                    expect(availability['errors'][0]['message']).to eq("Variable $input of type CreateAvailabilityInput! was provided invalid value for params.start (Field is not defined on UserInput), params.end (Field is not defined on UserInput)")
                end
            end
        end
    end
end
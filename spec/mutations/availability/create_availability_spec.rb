require 'rails_helper'

module Mutations
    module Availability
        RSpec.describe CreateAvailability, type: :request do
            before :each do
                @user = User.create(email: "JB@email.com", username: "Jim Bobby", password: "1234")
                @availabilityCreate = <<-GRAPHQL
                                mutation($input: CreateAvailabilityInput!) {
                                    createAvailability(input: $input) {
                                        availability {
                                            id
                                            startDateTime
                                            endDateTime
                                        }
                                    }
                                }
                            GRAPHQL
            end
            describe "Happy Paths - " do
                it "An availability can be created" do
                    # require 'pry'; binding.pry
                    # Availability.create(start_date_time: DateTime.new.to_s, end_date_time: DateTime.new.to_s, status: 0)
                    availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: DateTime.new.to_s, endDateTime: DateTime.new.to_s, status: 0, userId: @user.id.to_s } }})
                    require 'pry'; binding.pry
                end
            end

            describe "Sad Paths - " do
            end
        end
    end
end
require "rails_helper"
module Queries
    module Availability
        RSpec.describe GetAvailabilities, type: :request do 
            before :each do 
                @user = User.create(id: "1", email:"john@email.com", username: "John", password:"1234")
                @dt = DateTime.new.to_i.to_s
                @open = ::Availability.create(user: @user, start_date_time: @dt, end_date_time: @dt, status: 0 )
                @fulfilled = ::Availability.create(user: @user, start_date_time: @dt, end_date_time: @dt, status: 1 )
                @cancelled = ::Availability.create(user: @user, start_date_time: @dt, end_date_time: @dt, status: 2 )
                @get_availabilities = <<-GRAPHQL
                                    query($userId: ID!, $status: String!) {
                                        getAvailabilities(userId: $userId, status: $status) {
                                            id
                                            startDateTime
                                            endDateTime
                                            status
                                        }
                                    }
                                GRAPHQL
            end
            describe "Happy Paths -" do 
                it "can query a users availabilities by status open" do
                    availabilities = TomoApiSchema.execute(@get_availabilities, variables: { userId: @user.id, status: "open" } )
                    require 'pry'; binding.pry
                    expect(user["data"]["getUser"]["id"]).to eq("1")
                    expect(user["data"]["getUser"]["username"]).to eq("John")
                    expect(user["data"]["getUser"]["email"]).to eq("john@email.com")
                end
            end
            describe "Sad Paths -" do 
            end
        end
    end
end
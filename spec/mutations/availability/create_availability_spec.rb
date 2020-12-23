require 'rails_helper'

module Mutations
  module Availabilities
    RSpec.describe CreateAvailability, type: :request do
      before :each do
        @start_date_time = DateTime.new(2021, 1, 1, 8, 30)
        @end_date_time = DateTime.new(2021, 1, 1, 12, 30)
        @user = User.create(email: 'JB@email.com', username: 'Jim Bobby', password: '1234')
        @availabilityCreate = <<-GRAPHQL
                        mutation($input: CreateAvailabilityInput!) {
                            createAvailability(input: $input) {
                                availability {
                                    userId
                                    startDateTime
                                    endDateTime
                                    status
                                }
                            }
                        }
                    GRAPHQL


                    query_string = <<~GQL
   query {
     getUsers {
       id
       name
       email 
       birthdate
     }
   }
GQL
      end

      describe 'Happy Paths' do
        # it 'An availability can be created with default status of open' do
        #   response = TomoApiSchema.execute(@availabilityCreate, variables: { input: { startDateTime: @start_date_time, endDateTime: @end_date_time, userId: @user.id }})



        #   expect(response['data']['createAvailability']['availability']['id']).to_not be(nil)
        #   expect(response['data']['createAvailability']['availability']['userId']).to eq(@user.id.to_s)
        #   expect(response['data']['createAvailability']['availability']['startDateTime']).to eq(@dt)
        #   expect(response['data']['createAvailability']['availability']['endDateTime']).to eq(@dt)
        #   expect(response['data']['createAvailability']['availability']['status']).to eq('open')
        # end

        it 'An availability can be created as fulfilled' do

          post '/graphql', params: { query: query(user_id: @user.id, status: 1) }
          json = JSON.parse(response.body)
require 'pry'; binding.pry

          # response = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @start_date_time, endDateTime: @end_date_time, userId: @user.id, status: 1 } }})

          expect(json['data']['createAvailability']['availability']['id']).to_not be(nil)
          expect(json['data']['createAvailability']['availability']['userId']).to eq(@user.id.to_s)
          expect(json['data']['createAvailability']['availability']['startDateTime']).to eq(@dt)
          expect(json['data']['createAvailability']['availability']['endDateTime']).to eq(@dt)
          expect(json['data']['createAvailability']['availability']['status']).to eq('fulfilled')
        end

        it 'An availability can be created as cancelled' do
          response = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @start_date_time, endDateTime: @end_date_time, userId: @user.id, status: 2 } }})

          expect(response['data']['createAvailability']['availability']['id']).to_not be(nil)
          expect(response['data']['createAvailability']['availability']['userId']).to eq(@user.id.to_s)
          expect(response['data']['createAvailability']['availability']['startDateTime']).to eq(@dt)
          expect(response['data']['createAvailability']['availability']['endDateTime']).to eq(@dt)
          expect(response['data']['createAvailability']['availability']['status']).to eq('cancelled')
        end
      end

      def query(user_id:, status:)
        <<~GQL
          mutation {
            createAvailability(
              userId: #{user_id}
              startDateTime: 'Fri, 01 Jan 2021 08:30:00 +0000'
              endDateTime: 'Fri, 01 Jan 2021 12:30:00 +0000'
              status: #{status}
            ) {
              userId
              startDateTime
              endDateTime
              status
            }
          }
        GQL
      end

      # describe 'Sad Paths - ' do
      #     it 'An availability cannot be created without userId' do
      #         availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, endDateTime: @dt } }})

      #         expect(availability['errors'][0]['message']).to eq("Invalid attributes for Availability: User must exist")
      #     end

      #     it "An availability cannot be created without a start date" do
      #         availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { endDateTime: @dt, userId: @user.id } }})

      #         expect(availability['errors'][0]['message']).to eq("Invalid attributes for Availability: Start date time can't be blank")
      #     end

      #     it "An availability cannot be created without an end date" do
      #         availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { startDateTime: @dt, userId: @user.id } }})

      #         expect(availability['errors'][0]['message']).to eq("Invalid attributes for Availability: End date time can't be blank")
      #     end

      #     it "An availability cannot be created with unknown attributes" do
      #         availability = TomoApiSchema.execute(@availabilityCreate, variables: { input: { params: { start: @dt, end: @dt, userId: @user.id } }})

      #         expect(availability['errors'][0]['message']).to eq("Variable $input of type CreateAvailabilityInput! was provided invalid value for params.start (Field is not defined on UserInput), params.end (Field is not defined on UserInput)")
      #     end
      # end
    end
  end
end
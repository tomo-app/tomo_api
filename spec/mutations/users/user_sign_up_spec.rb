require 'rails_helper'

module Mutations
    module Users
        RSpec.describe UserSignUp, type: :request do
            before :each do
                @user_sign_up = <<-GRAPHQL
                                mutation($input: UserSignUpInput!) {
                                    userSignUp(input: $input) {
                                        user {
                                            id
                                            username
                                            email
                                        }
                                    }
                                }
                            GRAPHQL
            end
            describe "Happy Paths - " do
                it "A user can be created" do
                    user = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "JB@email.com", username: "Jim Bobby", password: "1234", passwordConfirmation: "1234" } }})

                    expect(user["data"]["userSignUp"]["user"]["id"]).to_not eq(nil)

                    expect(user["data"]["userSignUp"]["user"]["username"]).to be_a(String)
                    expect(user["data"]["userSignUp"]["user"]["username"]).to eq("Jim Bobby")

                    expect(user["data"]["userSignUp"]["user"]["email"]).to be_a(String)
                    expect(user["data"]["userSignUp"]["user"]["email"]).to eq("JB@email.com")
                end
            end

            describe "Sad Paths - " do
                it "A user cannot be created with an existing email" do 
                    first_bob = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "JB@email.com", username: "Jim Bobby", password: "1234", passwordConfirmation: "1234" } }})

                    second_bob = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "JB@email.com", username: "J Biebs", password: "1234", passwordConfirmation: "1234" } }})

                    expect(first_bob["data"]["userSignUp"]["user"]["email"]).to eq("JB@email.com")

                    expect(second_bob["errors"][0]["message"]). to eq("Invalid attributes for User: Email has already been taken")
                end

                it "A user cannot be created with a passwordConfirmation that doesnt match password" do 
                    bob = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "JB@email.com", username: "Jim Bobby", password: "1234", passwordConfirmation: "DOESNTMATCH" } }})

                    expect(bob["errors"][0]["message"]). to eq("passwords must match")
                end

                it "A user cannot be created with a missing passwordConfirmation" do 
                    bob = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "JB@email.com", username: "Jim Bobby", password: "1234" } }})

                    expect(bob["errors"][0]["message"]). to eq("passwords must match")
                end

                it "A user cannot be created with an existing username" do
                    first_bob = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "JB@email.com", username: "Jim Bobby", password: "1234", passwordConfirmation: "1234" } }})

                    second_bob = TomoApiSchema.execute(@user_sign_up, variables: { input: { params: { email: "anotherBOB@email.com", username: "Jim Bobby", password: "1234", passwordConfirmation: "1234" } }})

                    expect(first_bob["data"]["userSignUp"]["user"]["username"]).to eq("Jim Bobby")
                    expect(second_bob["errors"][0]["message"]).to eq("Invalid attributes for User: Username has already been taken")
                end
            end
        end
    end
end
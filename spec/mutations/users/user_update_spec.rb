require 'rails_helper'

module Mutations
    module Users
        RSpec.describe UserUpdate, type: :request do
            before :each do
                @old_user = User.create(email: "JB@email.com", username: "Jim Bobby", password: "1234")
                @user_update = <<-GRAPHQL
                                mutation($input: UserUpdateInput!) {
                                    userUpdate(input: $input) {
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
                it "A user can be updated" do
                    updated_user = TomoApiSchema.execute(@user_update, variables: { input: { params: { id: @old_user.id.to_s, email: "updated_value@email.com", username: "updated_value", password:"1234" } }})

                    expect(updated_user["data"]["userUpdate"]["user"]["id"]).to_not eq(nil)

                    expect(updated_user["data"]["userUpdate"]["user"]["username"]).to eq("updated_value")
                    expect(updated_user["data"]["userUpdate"]["user"]["email"]).to eq("updated_value@email.com")
                end

                it "A user can update their password" do
                    updated_user = TomoApiSchema.execute(@user_update, variables: { input: { params: { id: @old_user.id.to_s, email: "JB@email.com", username: "Jim Bobby", password:"new_password" } }})
                    updated_user = User.find(@old_user.id)

                    expect(@old_user.password).to_not eq(updated_user.password)
                end
            end

            describe "Sad Paths - " do
                it "A user cannot be updated without providing id" do
                    non_updated_user = TomoApiSchema.execute(@user_update, variables: { input: { params: { email: "updated_value@email.com", username: "updated_value", password:"1234" } }})

                    expect(non_updated_user["errors"][0]["message"]).to eq("You must provide a user id to update a user")
                end
                it "A user cannot be updated when provided invalid attributes" do
                    non_updated_user = TomoApiSchema.execute(@user_update, variables: { input: { params: { id: @old_user.id.to_s, email: "updated_value@email.com", name: "updated_value", password:"1234" } }})

                    expect(non_updated_user["errors"][0]["message"]).to eq("Variable $input of type UserUpdateInput! was provided invalid value for params.name (Field is not defined on UserInput)")
                end
            end
        end
    end
end
require "rails_helper"
module Queries
    module Users
        RSpec.describe QueryUsers, type: :request do 
            before :each do 
                User.create(id: "1", email:"john@email.com", username: "John", password:"1234")
                User.create(id: "2", email:"jared@email.com", username: "Jared", password:"1234")
                @query_user = <<-GRAPHQL
                                    query($id: ID!) {
                                        queryUser(id: $id) {
                                            id
                                            username
                                            email
                                        }
                                    }
                                GRAPHQL
                @query_users = <<-GRAPHQL
                                    query {
                                        queryUsers {
                                            id
                                            username
                                            email
                                        }
                                    }
                                GRAPHQL
            end
            describe "Happy Paths - " do 
                it "can query a single user by id" do
                    user = TomoApiSchema.execute(@query_user, variables: { id: 1 } )
                    expect(user["data"]["queryUser"]["id"]).to eq("1")
                    expect(user["data"]["queryUser"]["username"]).to eq("John")
                    expect(user["data"]["queryUser"]["email"]).to eq("john@email.com")

                    user = TomoApiSchema.execute(@query_user, variables: { id: 2 } )
                    expect(user["data"]["queryUser"]["id"]).to eq("2")
                    expect(user["data"]["queryUser"]["username"]).to eq("Jared")
                    expect(user["data"]["queryUser"]["email"]).to eq("jared@email.com")

                end

                it "can query all users" do
                    users = TomoApiSchema.execute(@query_users)

                    expect(users["data"]["queryUsers"].size).to eq(User.all.size)

                    expect(users["data"]["queryUsers"][0]).to eq({"id"=>"2", "username"=>"Jared", "email"=>"jared@email.com"})
                    expect(users["data"]["queryUsers"][1]).to eq({"id"=>"1", "username"=>"John", "email"=>"john@email.com"})
                end
            end
            describe "Sad Paths - " do 
                it "cannot query a user that doesnt exist" do
                    user = TomoApiSchema.execute(@query_user, variables: { id: 234089572034 } )

                    expect(user["errors"][0]["message"]).to eq("User does not exist.")
                end

                it "cannot query a user when providing wrong parameters" do
                    user = TomoApiSchema.execute(@query_user, variables: { username: "John" } )

                    expect(user["errors"][0]["message"]).to eq("Variable $id of type ID! was provided invalid value")
                end

                it "cannot query a single user without providing id" do
                    user = TomoApiSchema.execute(@query_user)

                    expect(user["errors"][0]["message"]).to eq("Variable $id of type ID! was provided invalid value")
                end
            end
        end
    end
end
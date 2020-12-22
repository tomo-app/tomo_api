require "rails_helper"
module Queries
    module Users
        RSpec.describe GetUsers, type: :request do 
            before :each do 
                User.create(id: "1", email:"john@email.com", username: "John", password:"1234")
                User.create(id: "2", email:"jared@email.com", username: "Jared", password:"1234")
                @get_user = <<-GRAPHQL
                                    query($id: ID!) {
                                        getUser(id: $id) {
                                            id
                                            username
                                            email
                                        }
                                    }
                                GRAPHQL
                @get_users = <<-GRAPHQL
                                    query {
                                        getUsers {
                                            id
                                            username
                                            email
                                        }
                                    }
                                GRAPHQL
            end
            describe "Happy Paths -" do 
                it "can query a single user by id" do
                    user = TomoApiSchema.execute(@get_user, variables: { id: 1 } )
                    expect(user["data"]["getUser"]["id"]).to eq("1")
                    expect(user["data"]["getUser"]["username"]).to eq("John")
                    expect(user["data"]["getUser"]["email"]).to eq("john@email.com")

                    user = TomoApiSchema.execute(@get_user, variables: { id: 2 } )
                    expect(user["data"]["getUser"]["id"]).to eq("2")
                    expect(user["data"]["getUser"]["username"]).to eq("Jared")
                    expect(user["data"]["getUser"]["email"]).to eq("jared@email.com")

                end

                it "can query all users" do
                    users = TomoApiSchema.execute(@get_users)

                    expect(users["data"]["getUsers"].size).to eq(User.all.size)

                    expect(users["data"]["getUsers"][0]).to eq({"id"=>"1", "username"=>"John", "email"=>"john@email.com"})
                    expect(users["data"]["getUsers"][1]).to eq({"id"=>"2", "username"=>"Jared", "email"=>"jared@email.com"})
                end
            end
            describe "Sad Paths -" do 
                it "cannot query a user when providing wrong parameters" do
                    user = TomoApiSchema.execute(@get_user, variables: { username: "John" } )

                    expect(user["errors"][0]["message"]).to eq("Variable $id of type ID! was provided invalid value")
                end

                it "cannot query a single user without providing id" do
                    user = TomoApiSchema.execute(@get_user)

                    expect(user["errors"][0]["message"]).to eq("Variable $id of type ID! was provided invalid value")
                end
            end
        end
    end
end
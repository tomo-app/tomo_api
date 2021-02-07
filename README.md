<img src="app/assets/images/logo.png" width="200"><br>

![rails-badge](https://img.shields.io/badge/Rails-6.1.0-informational?style=flat-square) ![ruby-badge](https://img.shields.io/badge/Ruby-2.7.2-informational?style=flat-square) ![build-badge](https://img.shields.io/travis/tomo-riff-raff/tomo_api/main?style=flat-square) ![closed-pr-badge](https://img.shields.io/github/issues-pr-closed-raw/tomo-riff-raff/tomo_api?style=flat-square)

This GraphQL on Rails API serves queries and mutations to Tomo, an application for language exchange pairing.

## Readme Content
- [Local Setup](#local-setup)
- [Test Suite](#test-suite)
- [GraphQL Schema](#graphql-schema)
- [Database Schema](#database-schema)
- [Project Board](#project-board)

## Local Setup
### Prerequisites:
- Ruby 2.7.2
- Rails 6.1

### Install gems and setup database:
- Install gems:
    -  `bundle` (if this fails, try to `bundle update` and then retry)

- Setup database:
  - `rails db:create`
  - `rails db:migrate`
  - `rails db:seed`

- To run your own development server:
  - `rails s`
  - You should be able to access the GraphQL interface and see available queries and mutations via the docs on [http://localhost:3000/graphiql](http://localhost:3000/graphiql)

## Test Suite
- Run with `bundle exec rspec`
- All tests should be passing
- To view specific test coverage: `open coverage/index.html` 

## GraphQL Schema
- Endpoint: POST https://tomo-api.herokuapp.com/graphql

### Queries & Mutations
#### Availabilities
  - **Get Availabilities**: fetch all availabilities for a user by id
    - Type: [Availability](#availability)
    - Arguments: 
      ```
      argument :user_id, ID, required: true
      argument :status, String, required: false
      ```
    - <details>
        <summary>Example request</summary>

        ```
        {
          getAvailabilities(userId: "1") {
            id
            userId
            status
          }
        }
        ```
      </details><br>

  - **Create Availability**: create new availability slot for a user with default status of 'open'
    - Type: [Availability](#availability)
    - Arguments: 
      ```
      argument :user_id, ID, required: true
      argument :start_date_time, Integer, required: true
      argument :end_date_time, Integer, required: true
      argument :status, Integer, required: false
      ```
    - <details>
        <summary>Example request</summary>

        ```
        mutation {
          createAvailability(input: { params: {
            userId: "2",
            startDateTime: 1609493400,
            endDateTime: 1609504200
          }}) {
            id
            userId
            startDateTime
            endDateTime
            status
          }
        }
        ```
      </details><br>

  - **Update Availability**: fetch information for a user by id
    - Type: [Availability](#availability)
    - Arguments: 
      ```
      argument :id, ID, required: true
      argument :start_date_time, Integer, required: false
      argument :end_date_time, Integer, required: false
      argument :status, Integer, required: false
      ```
    - `status: "1"`: 'fulfilled', `status: "2"`: 'open'
    - <details>
        <summary>Example request</summary>

        ```
        mutation {
          updateAvailability(input: { 
              id: "2", 
              startDateTime: 1612324800, 
              endDateTime: 1612328400, 
              status: 1
          }) {
            id
            userId
            startDateTime
            endDateTime
            status
          }
        }
        ```
      </details><br>

#### Blocked Pairings
  - **Create Blocked Pairing**: create a new blocked pairing for a user
    - Type: [Blocked Pairing](#blocked-pairing)
    - Arguments: 
      ```
      argument :blocking_user_id, ID, required: true
      argument :blocked_user_id, ID, required: true
      ```
    - <details>
        <summary>Example request</summary>

        ```
        mutation {
          createBlockedPairing(input: { params: {
            blockingUserId: "1",
            blockedUserId: "2"
          }}) {
            id
            blockingUserId
            blockedUserId
          }
        }
        ```
      </details><br>

#### Language
  - **Get Languages**: get all languages currently supported by the application
    - Type: [Language](#language)
    - <details>
        <summary>Example request</summary>

        ```
        {
          getLanguages {
            id
            name
          }
        }
        ```
      </details><br>

#### Pairing
  - **Get Pairings**: fetch all pairings for a user by id
    - Type: [Pairing](#pairing)
    - Argument: 
      ```
      argument :user_id, ID, required: true
      ```
    - <details>
        <summary>Example request</summary>

        ```
        {
          getPairings(userId: "1") {
            id
            user1Id
            user2Id
            cancelled
          }
        }
        ```
      </details><br>

#### User Language
#### Users
  - **Get User**: fetch information for a user by id
    - Type: [User](#user)
    - Argument: 
      ```
      argument :id, ID, required: true
      ```
    - <details>
        <summary>Example request</summary>

        ```
        {
          getUser(id: "1") {
            id
            username
            email
            availabilities {
              id
            }
            userLanguages {
                id
            }
          }
        }
        ```
      </details><br>

  - **Create User**: sign up a new user
    - Type: [User](#user)
    - Arguments: 
      ```
      argument :email, String, required: true
      argument :username, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      ```
    - <details>
        <summary>Example request</summary>

          ```
          mutation {
            createUser(input: { params: {
              email: "user@email.com", 
              username: "user", 
              password: "1234", 
              passwordConfirmation: "1234" }
            }) {
              id
              username
              email
            }
          }
          ```
      </details><br>

  - **Update User**: update an existing user
    - Type: [User](#user)
    - Arguments: 
      ```
      argument :id, Integer, required: true
      argument :email, String, required: false
      argument :username, String, required: false
      argument :target_language_id, String, required: false
      argument :native_language_id, String, required: false
      ```
    - <details>
        <summary>Example request</summary>

          ```
          mutation {
            updateUser(input: {id: 1, username: "person", email: "person@email.com", targetLanguageId: "2", nativeLanguageId: "1"}) {
              id
              username
              email
              userLanguages {
                id
                userId
                languageId
                fluencyLevel
              }
            }
          }
          ```
      </details><br>

### Types
- #### Availability
  ```
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :start_date_time, String, null: false
    field :end_date_time, String, null: false
    field :status, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
  ```
- #### Blocked Pairing
  ```
    field :id, ID, null: false
    field :blocking_user_id, ID, null: false
    field :blocked_user_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  ```
- #### Language
  ```
    field :id, ID, null: false
    field :name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  ```
- #### Pairing
  ```
    field :id, ID, null: false
    field :user1_id, ID, null: false
    field :user2_id, ID, null: false
    field :date_time, Integer, null: false
    field :user1_cancelled, Boolean, null: false
    field :user2_cancelled, Boolean, null: false
    field :cancelled, Boolean, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  ```
- #### User Language
  ```
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :language_id, ID, null: false
    field :fluency_level, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false

  ```
- #### User
  ```
    field :id, ID, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :availabilities, [Types::AvailabilityType], null: false
    field :user_languages, [Types::UserLanguageType], null: false
  ```

## Database Schema
![schema](/schema.png)
### Tables:
  - **Users**: users that have signed up for the application
  - **Availabilities**: user's time slots of open availability for pairing
  - **Pairings**: language exchange sessions that have been scheduled
  - **Blocked Pairings**: when a user does not wish no pair with another again, they can add that user to their blocked pairings
  - **Languages**: languages currently supported by the application
  - **User Languages**: languages that a user has chosen as either their native or target learning language
  - **Topics**: conversation topics
  - **Topic Translations**: translation of each conversation topic to supported languages

## Project Board
[GitHub project](https://github.com/orgs/tomo-riff-raff/projects/1)

# TOMO
  - [Setup](#setup)
    - [Prerequisites](#prerequisites)
    - [Installation](#testing)
  - [Endpoint](#endpoint)
  - [API Calls](#api-calls)
    - [User](#user)
## Setup
### Prerequisites
- Ruby 2.7.2
- Rails 6.1

### Installation
#### Install gems and setup your database:
```
bundle install
rails db:create
rails db:migrate
```

## Endpoint

```POST https://feed-the-people-api.herokuapp.com/graphql```

## API Calls
### User
- createUser
```
mutation {
  createUser(input: {params: {email: "jim@email.com", username: "jim", password: "1234", passwordConfirmation: "1234"}}) {
    id
    username
    email
  }
}
```
- updateUser
```
mutation {
  updateUser(input: {id: "3", username: "Ted", email: "Ted@email.com", targetId: "2", nativeId: "1"}) {
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

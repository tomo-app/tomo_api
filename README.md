# TOMO
  - [Setup](#setup)
    - [Prerequisites](#prerequisites)
    - [Installation](#testing)
  - [Endpoint](#endpoint)
  - [API Calls](#api-calls)
    - [Users](#users)
    - [Availabilities](#availabilities)
    - [UserLanguages](#userlanguages)
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

```POST https://tomo-api.herokuapp.com/graphql```

## API Calls
### Users
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
- pass a `nativeId` or `targetId` (languageId) to update a user's target or native language
```
mutation {
  updateUser(input: {id: "3", username: "Ted", email: "Ted@email.com", targetLanguageId: "2", nativeLanguageId: "1"}) {
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
- getUser
```
{
  getUser(id: "1") {
    id
    username
    email
    availabilities {
      id
      userId
      startDateTime
      endDateTime
      status
      createdAt
      updatedAt
    }
    userLanguages {
        id
        userId
        languageId
        fluencyLevel
        createdAt
        updatedAt
    }
  }
}
```
- getUsers
```
{
  getUsers {
    id
    username
    email
    availabilities {
      id
      userId
      startDateTime
      endDateTime
      status
      createdAt
      updatedAt
    }
    userLanguages {
        id
        userId
        languageId
        fluencyLevel
        createdAt
        updatedAt
    }
  }
}
```
### Availabilities
- createAvailability
- default status is 'open'. 
```
mutation {
  createAvailability(input: {params: {userId: "2", startDateTime: "1609493400", endDateTime: "1609504200"}}) {
    id
    userId
    startDateTime
    endDateTime
    status
  }
}
```
- updateAvailability
- `status: "1"`: 'fulfilled', `status: "2"`: 'open'
```
mutation {
  updateAvailability(input: {id: "2", startDateTime: 1612324800, endDateTime: 1612328400, status: 1}) {
    id
    userId
    startDateTime
    endDateTime
    status
  }
}
```
### UserLanguages
- createUserLanguage
```
mutation {
  createUserLanguage(input: {params: {languageId: "2", userId: "1", fluencyLevel: "0"}}) {
    id
    languageId
    userId
    fluencyLevel
  }
}
```

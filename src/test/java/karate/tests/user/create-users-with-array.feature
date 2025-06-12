Feature: Create users in bulk using POST /user/createWithArray

  Background:
    * call read('common-user.feature')
    * def createWithArrayPath = 'createWithArray'

  Scenario: Create multiple users with valid data (array)
    Given path createWithArrayPath
    And request users_array
    When method post
    Then status 200

  Scenario: Create users with empty array
    Given path createWithArrayPath
    And request []
    When method post
    Then status 400

  Scenario: Create users with one missing username
    * def users = JSON.parse(JSON.stringify(users_array))
    * remove users[1].username

    Given path createWithArrayPath
    And request users
    When method post
    Then status 400

  Scenario: Create users with duplicate IDs
    * def users = JSON.parse(JSON.stringify(users_array))
    * set users[1].id = users[0].id

    Given path createWithArrayPath
    And request users
    When method post
    Then status 409


  Scenario: Create users with duplicate usernames in the same request
    * def users = JSON.parse(JSON.stringify(users_array))
    * set users[1].username = users[0].username

    Given path createWithArrayPath
    And request users
    When method post
    Then status 409

  Scenario: Create users where one has only ID and username
    * def users = JSON.parse(JSON.stringify(users_array))
    * remove users[1].firstName
    * remove users[1].lastName
    * remove users[1].email
    * remove users[1].password
    * remove users[1].phone
    * remove users[1].userStatus

    Given path createWithArrayPath
    And request users
    When method post
    Then status 400


  Scenario: Create users with invalid data type in one entry
    * def users = JSON.parse(JSON.stringify(users_array))
    * set users[1].id = 'invalid_type_id'

    Given path createWithArrayPath
    And request users
    When method post
    Then status 400

  Scenario: Create users with malformed JSON
    Given path createWithArrayPath
    And header Content-Type = 'application/json'
    And request malformed_json_users_array
    When method post
    Then status 400



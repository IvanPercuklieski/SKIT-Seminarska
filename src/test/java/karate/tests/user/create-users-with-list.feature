Feature: Create users in bulk using POST /user/createWithList

  Background:
    * call read('common-user.feature')
    * def createWithListPath = 'createWithList'

  Scenario: Create multiple users with valid data (list)
    Given path createWithListPath
    And request users_list
    When method post
    Then status 200

  Scenario: Create users with empty list
    Given path createWithListPath
    And request []
    When method post
    Then status 400

  Scenario: Create users with one missing username
    * def users = JSON.parse(JSON.stringify(users_list))
    * remove users[1].username

    Given path createWithListPath
    And request users
    When method post
    Then status 400


  Scenario: Create users with duplicate IDs
    * def users = JSON.parse(JSON.stringify(users_list))
    * set users[1].id = users[0].id

    Given path createWithListPath
    And request users
    When method post
    Then status 409


  Scenario: Create users with duplicate usernames in the same request
    * def users = JSON.parse(JSON.stringify(users_list))
    * set users[1].username = users[0].username

    Given path createWithListPath
    And request users
    When method post
    Then status 400


  Scenario: Create users where one has only ID and username
    * def users = JSON.parse(JSON.stringify(users_list))
    * remove users[1].firstName
    * remove users[1].lastName
    * remove users[1].email
    * remove users[1].password
    * remove users[1].phone
    * remove users[1].userStatus

    Given path createWithListPath
    And request users
    When method post
    Then status 409


  Scenario: Create users with invalid data type in one entry
    * def users = JSON.parse(JSON.stringify(users_list))
    * set users[1].id = 'invalid_type_id'

    Given path createWithListPath
    And request users
    When method post
    Then status 400

  Scenario: Create users with malformed JSON
    Given path createWithListPath
    And header Content-Type = 'application/json'
    And request malformed_json_users_list
    When method post
    Then status 400

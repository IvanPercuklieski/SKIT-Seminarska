Feature: Create users in bulk using POST /user/createWithArray

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

  Scenario: Create multiple users with valid data (array)
    Given path 'createWithArray'
    And request
      """
      [
        {
          "id": 601,
          "username": "array_user1",
          "firstName": "Array",
          "lastName": "One",
          "email": "array1@example.com",
          "password": "pass1",
          "phone": "070000001",
          "userStatus": 1
        },
        {
          "id": 602,
          "username": "array_user2",
          "firstName": "Array",
          "lastName": "Two",
          "email": "array2@example.com",
          "password": "pass2",
          "phone": "070000002",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 200

  Scenario: Create users with empty array
    Given path 'createWithArray'
    And request []
    When method post
    Then status 400

  Scenario: Create users with one missing username
    Given path 'createWithArray'
    And request
      """
      [
        {
          "id": 603,
          "username": "array_user3",
          "firstName": "Array",
          "lastName": "Three",
          "email": "array3@example.com",
          "password": "pass3",
          "phone": "070000003",
          "userStatus": 1
        },
        {

          "id": 604,
          "firstName": "Missing Username",
          "lastName": "Four",
          "email": "array4@example.com",
          "password": "pass4",
          "phone": "070000004",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 400

  Scenario: Create users with duplicate IDs
    Given path 'createWithArray'
    And request
      """
      [
        {
          "id": 605,
          "username": "duplicate1",
          "firstName": "Array",
          "lastName": "Five",
          "email": "array5@example.com",
          "password": "pass5",
          "phone": "070000005",
          "userStatus": 1
        },
        {
          "id": 605,
          "username": "duplicate2",
          "firstName": "Array",
          "lastName": "Six",
          "email": "array6@example.com",
          "password": "pass6",
          "phone": "070000006",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 409

  Scenario: Create users with duplicate usernames in the same request
    Given path 'createWithArray'
    And request
      """
      [
        {

          "id": 607,
          "username": "duplicate_user",
          "firstName": "Array",
          "lastName": "Seven",
          "email": "array7@example.com",
          "password": "pass7",
          "phone": "070000007",
          "userStatus": 1
        },
        {
          "id": 608,
          "username": "duplicate_user",
          "firstName": "Array",
          "lastName": "Eight",
          "email": "array8@example.com",
          "password": "pass8",
          "phone": "070000008",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 400

  Scenario: Create users where one has only ID and username
    Given path 'createWithArray'
    And request
      """
      [
        {
          "id": 609,
          "username": "ok_user",
          "firstName": "Array",
          "lastName": "Nine",
          "email": "array8@example.com",
          "password": "pass8",
          "phone": "070000008",
          "userStatus": 1
        },
        {
          "id": 610,
          "username": "not_ok_user"
        }
      ]
      """
    When method post
    Then status 400


  Scenario: Create users with invalid data type in one entry
    Given path 'createWithArray'
    And request
      """
      [
        {
          "id": 611,
          "username": "valid_user",
          "firstName": "Array",
          "lastName": "Eleven",
          "email": "array11@example.com",
          "password": "pass11",
          "phone": "070000011",
          "userStatus": 1
        },
        {
          "id": "invalid",
          "username": "invalid_user"
        }
      ]
      """
    When method post
    Then status 400



  #  Scenario: Create users with malformed JSON
  #    Given path 'user/createWithArray'
  #    And request
  #      """
  #      [
  #    { "id": 606, "username": "broken" "password": "oops" }
  #    ]
  #    """
  #    When method post
  #    Then status 400

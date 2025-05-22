Feature: Create users in bulk using POST /user/createWithList

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

  Scenario: Create multiple users with valid data (list)
    Given path 'createWithList'
    And request
      """
      [
        {
          "id": 701,
          "username": "list_user1",
          "firstName": "List",
          "lastName": "One",
          "email": "list1@example.com",
          "password": "pass1",
          "phone": "071000001",
          "userStatus": 1
        },
        {
          "id": 702,
          "username": "list_user2",
          "firstName": "List",
          "lastName": "Two",
          "email": "list2@example.com",
          "password": "pass2",
          "phone": "071000002",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 200

  Scenario: Create users with empty list
    Given path 'createWithList'
    And request []
    When method post
    Then status 400

  Scenario: Create users with one missing username
    Given path 'createWithList'
    And request
      """
      [
        {
          "id": 703,
          "username": "list_user3",
          "firstName": "List",
          "lastName": "Three",
          "email": "list3@example.com",
          "password": "pass3",
          "phone": "071000003",
          "userStatus": 1
        },
        {
          "id": 704,
          "firstName": "Missing Username",
          "lastName": "Four",
          "email": "list4@example.com",
          "password": "pass4",
          "phone": "071000004",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 400

  Scenario: Create users with duplicate IDs
    Given path 'createWithList'
    And request
      """
      [
        {
          "id": 705,
          "username": "duplicate1",
          "firstName": "List",
          "lastName": "Five",
          "email": "list5@example.com",
          "password": "pass5",
          "phone": "071000005",
          "userStatus": 1
        },
        {
          "id": 705,
          "username": "duplicate2",
          "firstName": "List",
          "lastName": "Six",
          "email": "list6@example.com",
          "password": "pass6",
          "phone": "071000006",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 409

  Scenario: Create users with duplicate usernames in the same request
    Given path 'createWithList'
    And request
      """
      [
        {
          "id": 707,
          "username": "duplicate_user",
          "firstName": "List",
          "lastName": "Seven",
          "email": "list7@example.com",
          "password": "pass7",
          "phone": "071000007",
          "userStatus": 1
        },
        {
          "id": 708,
          "username": "duplicate_user",
          "firstName": "List",
          "lastName": "Eight",
          "email": "list8@example.com",
          "password": "pass8",
          "phone": "071000008",
          "userStatus": 1
        }
      ]
      """
    When method post
    Then status 400

  Scenario: Create users where one has only ID and username
    Given path 'createWithList'
    And request
      """
      [
        {
          "id": 709,
          "username": "ok_user",
          "firstName": "List",
          "lastName": "Nine",
          "email": "array9@example.com",
          "password": "pass9",
          "phone": "070000009",
          "userStatus": 1
        },
        {
          "id": 710,
          "username": "not_ok_user"
        }
      ]
      """
    When method post
    Then status 400

  Scenario: Create users with invalid data type in one entry
    Given path 'createWithList'
    And request
      """
      [
        {
          "id": 711,
          "username": "valid_user",
          "firstName": "List",
          "lastName": "Eleven",
          "email": "list11@example.com",
          "password": "pass11",
          "phone": "071000011",
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

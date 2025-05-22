Feature: Retrieve user details using GET /user/{username}

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')


  Scenario: Get existing user
    # Step 1: Create the user
    Given path ''
    And request
      """
      {
        "id": 201,
        "username": "bojana_valid",
        "firstName": "Bojana",
        "lastName": "Petrovska",
        "email": "bojana@example.com",
        "password": "securePass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    # Step 2: Get the created user
    Given path 'bojana_valid'
    When method get
    Then status 200
    And match response ==
      """
      {
        "id": 201,
        "username": "bojana_valid",
        "firstName": "Bojana",
        "lastName": "Petrovska",
        "email": "bojana@example.com",
        "password": "securePass123",
        "phone": "+38970111222",
        "userStatus": 1
      }
      """

  Scenario: Get non-existent user
    Given path 'doesNotExist123'
    When method get
    Then status 404

  Scenario: Get user with empty username
    Given path ''
    When method get
    Then status 405

  Scenario: Get user after deletion
    # Step 1: Create user
    Given path ''
    And request
      """
      {
        "id": 202,
        "username": "bojana_deleted",
        "firstName": "Bojana",
        "lastName": "ToDelete",
        "email": "delete@example.com",
        "password": "delete123",
        "phone": "000000000",
        "userStatus": 0
      }
      """
    When method post
    Then status 200

    # Step 2: Delete user
    Given path 'bojana_deleted'
    When method delete
    Then status 200

    # Step 3: Try to get deleted user
    Given path 'bojana_deleted'
    When method get
    Then status 404




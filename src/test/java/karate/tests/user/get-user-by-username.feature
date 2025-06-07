Feature: Retrieve user details using GET /user/{username}

  Background:
    * call read('common-user.feature')


  Scenario: Get existing user
    # Create the user
    Given path ''
    And request user_get_valid
    When method post
    Then status 200

    # Get the created user
    Given path user_get_valid.username
    When method get
    Then status 200
    And match response == user_get_valid


  Scenario: Get non-existent user
    Given path 'doesNotExist123'
    When method get
    Then status 404

  Scenario: Get user with empty username
    Given path ''
    When method get
    Then status 405

  Scenario: Get user after deletion
    # Create the user
    Given path ''
    And request user_get_valid
    When method post
    Then status 200

    # Delete the user
    Given path user_get_valid.username
    When method delete
    Then status 200

    # Try to get deleted user
    Given path user_get_valid.username
    When method get
    Then status 404




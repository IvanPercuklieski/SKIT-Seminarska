Feature: Create user via POST /user endpoint

  Background:
    * call read('common-user.feature')

  Scenario: Create user with all valid fields
    Given path ''
    And request user_valid
    When method post
    Then status 200

  Scenario: Create user without ID field
    Given request user_missing_id
    When method post
    Then status 200

  Scenario: Create user without password field
    Given path ''
    And request user_missing_password
    When method post
    Then status 400

  Scenario: Create user with missing username
    Given path ''
    And request user_missing_username
    When method post
    Then status 400

  Scenario: Create user with only username field
    Given path ''
    And request user_only_username
    When method post
    Then status 400

  Scenario: Create user with string instead of numeric ID
    Given path ''
    And request user_invalid_id
    When method post
    Then status 400

  Scenario: Create user with empty string in password field
    Given path ''
    And request user_empty_password
    When method post
    Then status 400

  Scenario: Create user with existing ID
    # Create the user
    Given path ''
    And request user_existing_id_1
    When method post
    Then status 200

    # Try to create the same user - same id
    Given path ''
    And request user_existing_id_2
    When method post
    Then status 409

  Scenario: Create user with existing username
    # Create the user
    Given path ''
    And request user_existing_username_1
    When method post
    Then status 200

    # Try to create the same user - same username
    Given path ''
    And request user_existing_username_2
    When method post
    Then status 409

  Scenario: Create user with empty body
    Given path ''
    And request {}
    When method post
    Then status 400

  Scenario: Create user with malformed JSON
    Given path ''
    And header Content-Type = 'application/json'
    And request '{"id": 9999, "username": "badjson", "password": "test"'
    When method post
    Then status 400

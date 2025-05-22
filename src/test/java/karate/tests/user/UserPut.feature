Feature: Update user via PUT /user/{username} endpoint

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

  Scenario: Update existing user with valid data
    #Create user
    Given path ''
    And request
      """
      {
        "id": 501,
        "username": "update_user_valid",
        "firstName": "Old",
        "lastName": "Last Name",
        "email": "old@example.com",
        "password": "123456",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    #Update user
    Given path 'update_user_valid'
    And request
      """
      {
        "id": 501,
        "username": "update_user_valid",
        "firstName": "New",
        "lastName": "Last Name",
        "email": "new@example.com",
        "password": "654321",
        "phone": "071333444",
        "userStatus": 2
      }
      """
    When method put
    Then status 200


  Scenario: Update user with missing fields (partial update)
    #Create user
    Given path ''
    And request
      """
      {
        "id": 502,
        "username": "update_user_partial",
        "firstName": "First Name",
        "lastName": "Last Name",
        "email": "init@example.com",
        "password": "start123",
        "phone": "070999000",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    #Update  user
    Given path 'update_user_partial'
    And request
      """
      {
        "id": 502,
        "username": "update_user_partial",
        "firstName": "Only",
        "lastName": "Partial"
      }
      """
    When method put
    Then status 200

    # but in this case password and email is missing?

  Scenario: Update user with mismatched username
    #Create user
    Given path ''
    And request
      """
      {
        "id": 503,
        "username": "update_user_mismatch",
        "firstName": "Initial",
        "email": "init@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    #Update the user
    Given path 'update_user_mismatch'
    And request
      """
      {
        "id": 503,
        "username": "wrong_username",
        "firstName": "Mismatch",
        "email": "init@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method put
    Then status 200

  Scenario: Update user with empty body
    # Create  user
    Given path ''
    And request
      """
      {
        "id": 504,
        "username": "update_user_empty",
        "firstName": "First Name",
        "lastName": "Last Name",
        "email": "init@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path 'update_user_empty'
    And request {}
    When method put
    Then status 200

  # This returns 200 OK and the user is not updated

  Scenario: Update non-existent user
    Given path 'not_found_user'
    And request
      """
      {
        "id": 999,
        "username": "not_found_user",
        "firstName": "Ghost",
        "lastName": "Ghost Last Name",
        "email": "init@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method put
    Then status 200

  Scenario: Update user with string instead of ID
    # Create  user
    Given path ''
    And request
      """
      {
        "id": 505,
        "username": "update_user_type",
        "firstName": "First name",
        "lastName": "Last name",
        "email": "old@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path 'update_user_type'
    And request
      """
      {
        "id": "abc",
        "username": "update_user_type",
        "firstName": "First name",
        "lastName": "Last name",
        "email": "new@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method put
    Then status 400

  Scenario: Update user with only username field
    # Create  user
    Given path ''
    And request
      """
      {
        "id": 506,
        "username": "update_user_minimal",
        "firstName": "First name",
        "lastName": "Last name",
        "email": "old@example.com",
        "password": "only_usr",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    Given path 'update_user_minimal'
    And request
      """
      {
        "username": "update_user_minimal"
      }
      """
    When method put
    Then status 400

  Scenario: Update user without ID field
    # Create user
    Given path ''
    And request
      """
      {
        "id": 507,
        "username": "update_user_no_id",
        "firstName": "Before",
        "lastName": "NoID",
        "email": "noid@example.com",
        "password": "id123",
        "phone": "071222333",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    # Try updating without ID
    Given path 'user/update_user_no_id'
    And request
      """
      {
        "username": "update_user_no_id",
        "firstName": "After",
        "lastName": "NoID",
        "email": "noid_updated@example.com",
        "password": "id456",
        "phone": "071333444",
        "userStatus": 2
      }
      """
    When method put
    Then status 200

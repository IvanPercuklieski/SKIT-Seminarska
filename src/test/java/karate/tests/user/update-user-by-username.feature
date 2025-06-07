Feature: Update user via PUT /user/{username} endpoint

  Background:
    * call read('common-user.feature')

  Scenario: Update existing user with valid data
    # Create the user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user
    * def updated_user = JSON.parse(JSON.stringify(user_for_update))
    * set updated_user.firstName = 'New'
    * set updated_user.email = 'new@example.com'
    * set updated_user.phone = '071111222'

    Given path user_for_update.username
    And request updated_user
    When method put
    Then status 200


  Scenario: Update user with missing fields (partial update)
    # Create the user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user
    * def partial_updated_user = { id: user_for_update.id, username: user_for_update.username, firstName: 'Only', lastName: 'Partial' }

    Given path user_for_update.username
    And request partial_updated_user
    When method put
    Then status 200
    # In this case password and email are deleted - this is valid because the method is PUT

  Scenario: Update user with different username
    # Create the user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user
    * def updated_user = JSON.parse(JSON.stringify(user_for_update))
    * set updated_user.username = 'different_username'

    Given path user_for_update.username
    And request updated_user
    When method put
    Then status 200

  Scenario: Update user with empty body
    # Create the user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user
    Given path user_for_update.username
    And request {}
    When method put
    Then status 200
    # This returns 200 OK and the user is not updated

  Scenario: Update non-existing user
    * def non_existing_user = JSON.parse(JSON.stringify(user_for_update))
    * set non_existing_user.id = 333
    * set non_existing_user.username = 'non_existing_user'

    Given path non_existing_user.username
    And request non_existing_user
    When method put
    Then status 200

  Scenario: Update user with string instead of ID
    # Create the user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user
    * def updated_user = JSON.parse(JSON.stringify(user_for_update))
    * set updated_user.id = 'string_id'

    Given path user_for_update.username
    And request updated_user
    When method put
    Then status 400

  Scenario: Update user with only username field
    # Create  the user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user
    * def updated_user = { username: 'only_username' }

    Given path user_for_update.username
    And request updated_user
    When method put
    Then status 400

  Scenario: Update user without ID field
    # Create user
    Given path ''
    And request user_for_update
    When method post
    Then status 200

    # Update the user without ID
    * def updated_user = JSON.parse(JSON.stringify(user_for_update))
    * remove updated_user.id
    * set updated_user.firstName = 'Missing ID'
    * set updated_user.email = 'noid_updated@example.com'
    * set updated_user.userStatus = 2

    Given path user_for_update.username
    And request updated_user
    When method put
    Then status 200

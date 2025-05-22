Feature: Delete user via DELETE /user/{username} endpoint

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

  Scenario: Delete existing user
    # Create user
    Given path ''
    And request
      """
      {
        "id": 301,
        "username": "delete_user_123",
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

    # Delete user
    Given path 'delete_user_123'
    When method delete
    Then status 200

  Scenario: Delete non-existent user
    Given path 'ghost_user_123'
    When method delete
    Then status 404

  Scenario: Delete same user twice
    # Create user
    Given path ''
    And request
      """
      {
        "id": 302,
        "username": "delete_twice",
        "firstName": "Ana",
        "lastName": "Andovska",
        "email": "ana@example.com",
        "password": "securePass123",
        "phone": "070111333",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

    # First delete
    Given path 'delete_twice'
    When method delete
    Then status 200

    # Second delete
    Given path 'delete_twice'
    When method delete
    Then status 404

  Scenario: Delete with empty username
    Given path ''
    When method delete
    Then status 405

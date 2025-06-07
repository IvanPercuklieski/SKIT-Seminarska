  Feature: Delete user via DELETE /user/{username} endpoint

    Background:
      * call read('common-user.feature')

    Scenario: Delete existing user
      # Create the user
      Given path ''
      And request user_delete
      When method post
      Then status 200

      # Delete the user
      Given path user_delete.username
      When method delete
      Then status 200

    Scenario: Delete non-existent user
      Given path 'ghost_user_123'
      When method delete
      Then status 404

    Scenario: Delete same user twice
      # Create user
      Given path ''
      And request user_delete
      When method post
      Then status 200

      # First delete
      Given path user_delete.username
      When method delete
      Then status 200

      # Second delete
      Given path user_delete.username
      When method delete
      Then status 404

    Scenario: Delete with empty username
      Given path ''
      When method delete
      Then status 405

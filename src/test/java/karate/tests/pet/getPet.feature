
Feature: Find pets by status (GET /pet/findByStatus)

  Background:
    * url petstoreUrl

  Scenario: Find pets with valid status
    Given path 'pet/findByStatus'
    And param status = 'available'
    When method get
    Then status 200


  Scenario: Find pets with multiple valid statuses

    Given path 'pet/findByStatus'
    And param status = 'available,pending'
    When method get
    Then status 200



  Scenario: Find pets with unknown status
    Given path 'pet/findByStatus'
    And param status = 'unknown'
    When method get
    Then status 400


  Scenario: Find pets with empty status parameter
    Given path 'pet/findByStatus'
    And param status = ''
    When method get
    Then status 400

  Scenario: Find pets with missing status parameter
    Given path 'pet/findByStatus'
    When method get
    Then status 400

  Scenario: Find pets with null status parameter
    Given path 'pet/findByStatus'
    And param status = null
    When method get
    Then status 400

  Scenario: Find pets with status parameter containing special characters
    Given path 'pet/findByStatus'
    And param status = '@!$%^&*'
    When method get
    Then status 400

  Scenario: Find pets with very long status string
    * def longStatus = 'a'.repeat(500)
    Given path 'pet/findByStatus'
    And param status = longStatus
    When method get
    Then status 400

  Scenario: Find pets with numeric status parameter
    Given path 'pet/findByStatus'
    And param status = 12345
    When method get
    Then status 400



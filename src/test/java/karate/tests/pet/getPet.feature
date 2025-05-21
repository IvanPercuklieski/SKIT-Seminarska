Feature: Find pet by status

  Background:
    * url 'https://petstore.swagger.io/v2'


  Scenario:Find pets with valid multiple status values
    Given path 'pet/findByStatus'
    And param status = 'available,pending'
    When method get
    Then status 200

  Scenario: Find pets with an invalid status value
    Given path 'pet/findByStatus'
    And param status = 'bald'
    When method get
    Then status 200

  Scenario:Find pets with multiple valid status values
    Given path 'pet/findByStatus'
    And param status = 'available,sold'
    When method get
    Then status 200

  Scenario: Find pets with multiple valid and invalid status values
    Given path 'pet/findByStatus'
    And param status = 'available,computer'
    When method get
    Then status 200
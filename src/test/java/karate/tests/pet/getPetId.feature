Feature: Find pet by Id
  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario:Get a pet by valid ID
    Given path 'pet', 7329
    When method get
    Then status 404
    And match response.message == "Pet not found"

  Scenario:Get a pet by valid ID 2
    Given path 'pet', 1
    When method get
    Then status 200
    And match response.id == 1

  Scenario: Get a pet by invalid ID
    Given path 'pet', -1
    When method get
    Then status 404
    And match response.message == 'Pet not found'

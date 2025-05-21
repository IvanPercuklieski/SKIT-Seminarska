Feature: Delete pet by ID

  Background:
    * url 'https://petstore.swagger.io/v2'
    * header api_key = 'special-api'

  Scenario: Delete a pet by valid petId
    Given path 'pet',5
    When method delete
    Then status 200
    And match response.message == '5'

  Scenario: Attempt to delete a pet with an invalid petId
    Given path 'pet', 99999999
    When method delete
    Then status 404


  Scenario: Attempt to delete a pet without id
    Given path 'pet', ''
    When method delete
    Then status 405
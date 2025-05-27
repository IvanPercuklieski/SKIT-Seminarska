Feature: Get store inventory

  Background:
    * call read('common.feature')
    * url baseUrl

  Scenario: Checking sold, pending and available
    Given path '/store/inventory'
    When method get
    Then status 200

    And match response.sold == '#number'
    And match response.pending == '#number'
    And match response.available == '#number'

  Scenario: Check that inventory response is a map of string keys and number values
    Given path '/store/inventory'
    When method get
    Then status 200
    And match response == '#object'

    * def keys = Object.keys(response)
    * karate.forEach(keys, function(k){ karate.match(response[k], '#number') })
Feature: Get store inventory

  Background:
    * call read('common.feature')
    * url baseUrl

  Scenario: Verify response is a key-value map, where the values are the quantities
    Given path '/store/inventory'
    When method get
    Then status 200

    And match response.sold == '#number'
    And match response.pending == '#number'
    And match response.available == '#number'


  Scenario: Check common elements like "sold", "pending" and "available"
    Given path '/store/inventory'
    When method get
    Then status 200
    And match response == '#object'

    * def keys = Object.keys(response)
    * karate.forEach(keys, function(k){ karate.match(response[k], '#number') })
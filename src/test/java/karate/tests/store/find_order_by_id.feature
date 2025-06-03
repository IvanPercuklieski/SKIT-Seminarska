Feature: Find order by ID

  Background:
    * call read('common.feature')
    * url baseUrl

  Scenario: Get an order that exists
    # Place order
    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200

    # Get order
    * configure retry = { count: 5, interval: 1000 }
    * retry until responseStatus == 200 && parseInt(response.id) == validOrder.id
    Given path '/store/order', validOrder.id
    When method get


  Scenario: Try to get an order that doesnt exist
    Given path '/store/order', 42
    When method delete

    Given path 'store/order/42'
    When method get
    Then status 404
    And match response.message == "Order not found"


  Scenario: Getting an order with an invalid id format
    Given path 'store/order/invalid'
    When method get
    Then status 404


  Scenario: Trying to get an order without providing an ID
    Given path 'store/order/'
    When method get
    Then status 405

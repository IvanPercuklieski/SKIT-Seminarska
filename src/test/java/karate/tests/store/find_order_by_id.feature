Feature: Find order by ID

  Background:
    * call read('common.feature')
    * url baseUrl

  Scenario: Get an order that exists
    # Place order
    Given path '/store/order'
    And request exampleOrder
    When method post
    Then status 200

    # Get the placed order
    Given path 'store/order' , exampleOrder.id
    When method get
    Then status 200

    And match parseInt(response.id) == exampleOrder.id
    And match response.status == 'placed'

  Scenario: Get a non existing order
    Given path 'store/order/888888888888888'
    When method get
    Then status 404
    And match response.message == "Order not found"

  Scenario: Get a order with an invalid ID format
    Given path 'store/order/-23'
    When method get
    Then status 404

  Scenario: Get order without an ID
    Given path 'store/order/'
    When method get
    Then status 405

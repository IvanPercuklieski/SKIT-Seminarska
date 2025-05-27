Feature: Find order by ID

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def exampleOrder =
    """
    {
      "id": 80,
      "petId": 1,
      "quantity": 2,
      "shipDate": "2095-05-18T20:41:00.574Z",
      "status": "placed",
      "complete": true
    }
    """

  Scenario: Get an order thet exists
    # Place order
    Given path '/store/order'
    And request exampleOrder
    When method post
    Then status 200

    Given path 'store/order/80'
    When method get
    Then status 200

    And match response.id == 80
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
    Given path 'store/order'
    When method get
    Then status 405

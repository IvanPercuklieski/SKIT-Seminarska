Feature: Delete order by ID

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def exampleOrder =
    """
    {
      "id": 9852,
      "petId": 1,
      "quantity": 2,
      "shipDate": "2095-05-18T20:41:00.574Z",
      "status": "placed",
      "complete": true
    }
    """

  Scenario: Placing an order and delete it
    Given path '/store/order'
    And request exampleOrder
    When method post
    Then status 200

    Given path '/store/order/9852'
    When method delete
    Then status 200
    And match response.message == "9852"

  Scenario: Deleting an order that doesnt exist
    Given path '/store/order/777777777777777'
    When method delete
    Then status 404
    And match response.message == "Order Not Found"

  Scenario: Invalid ID
    Given path '/store/order/asdasd'
    When method delete
    Then status 404

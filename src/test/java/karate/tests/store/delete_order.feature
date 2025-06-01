Feature: Delete order by ID

  Background:
    * call read('common.feature')
    * url baseUrl

  Scenario: Deleting an order that exists
    # Placing an order
    Given path '/store/order'
    And request exampleOrder
    When method post
    Then status 200

    # Check if the order is placed
    * configure retry = { count: 5, interval: 1000 }
    Given path '/store/order', exampleOrder.id
    When method get
    Then retry until responseStatus == 200

    # Deleting the same order
    Given path '/store/order', exampleOrder.id
    When method delete
    Then status 200
    And match parseInt(response.message) == exampleOrder.id


  Scenario: Try to delete an order that doesnt exist
    # Deleting the order if it exists
    Given path '/store/order', 42
    When method delete

    # Trying to delete it again
    Given path '/store/order/', 42
    When method delete
    Then status 404
    And match response.message == "Order Not Found"


  Scenario: Deleting an order with an invalid id format
    Given path '/store/order/invalid'
    When method delete
    Then status 404


  Scenario: Trying to delete an order without providing an ID
    Given path '/store/order/'
    When method delete
    Then status 405

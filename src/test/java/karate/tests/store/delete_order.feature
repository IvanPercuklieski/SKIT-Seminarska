Feature: Delete order by ID

  Background:
    * call read('common.feature')
    * url baseUrl


  Scenario: Successfully place and then delete an order
    # Placing an order
    Given path '/store/order'
    And request exampleOrder
    When method post
    Then status 200

    # Deleting the same order
    Given path '/store/order' , exampleOrder.id
    When method delete
    Then status 200
    And match parseInt(response.message) == exampleOrder.id

  Scenario: Deleting an order that doesnt exist
    Given path '/store/order/777777777777777'
    When method delete
    Then status 404
    And match response.message == "Order Not Found"

  Scenario: Invalid ID test
    Given path '/store/order/-1'
    When method delete
    Then status 404

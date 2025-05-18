Feature: Place an order

  Background:
    * url 'https://petstore.swagger.io/v2'
    * def validOrder =
    """
    {
      "id": 9,
      "petId": 1,
      "quantity": 2,
      "shipDate": "2025-05-18T20:41:00.574Z",
      "status": "placed",
      "complete": true
    }
    """

  Scenario: Place a valid order
    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200

    And match response.id == 9
    And match response.petId == 1
    And match response.quantity == 2
    And match response.shipDate == "2025-05-18T20:41:00.574+0000"
    And match response.status == "placed"
    And match response.complete == true

  # TODO: Why is the response 200 OK
  Scenario: Place order with negative quantity
    * def orderWithNegativeQuantity = JSON.parse(JSON.stringify(validOrder))
    * set orderWithNegativeQuantity.quantity = -40

    Given path '/store/order'
    And request orderWithNegativeQuantity
    When method post
    Then status 200

  Scenario: Place order with invalid ID format
    * def orderWithInvalidIDFormat = JSON.parse(JSON.stringify(validOrder))
    * set orderWithInvalidIDFormat.id = "badId"

    Given path '/store/order'
    And request orderWithInvalidIDFormat
    When method post
    Then status 500

  Scenario: Place order with invalid date format
    * def orderWithInvalidDateFormat = JSON.parse(JSON.stringify(validOrder))
    * set orderWithInvalidDateFormat.shipDate = "205-205-18T20:41:00.574Z"

    Given path '/store/order'
    And request orderWithInvalidDateFormat
    When method post
    Then status 500

  Scenario: Place an order for a non existing pet
    * def orderWithNonExistingPetID = JSON.parse(JSON.stringify(validOrder))
    * set orderWithNonExistingPetID.petId = 12

    # Delete the pet
    Given path '/pet/delete/12'

    Given path '/store/order'
    And request orderWithNonExistingPetID
    When method post
    Then status 404

  Scenario: Placing the order with the same ID twice
    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200

    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200

  Scenario: Try to place order with wrong JSON
    Given path '/store/order'
    And request '{"id": 99, "petId" '
    When method post
    Then status 415




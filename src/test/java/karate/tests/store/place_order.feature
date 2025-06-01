Feature: Place an order

  Background:
    * call read('common.feature')
    * url baseUrl


  Scenario: Placing a valid order
    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200

    And match response.id == 9
    And match response.petId == "#number"
    And match response.quantity == 2
    And match response.shipDate == "2025-05-18T20:41:00.574+0000"
    And match response.status == "placed"
    And match response.complete == true


  Scenario: Placing an order with negative quantity
    * def orderWithNegativeQuantity = JSON.parse(JSON.stringify(validOrder))
    * set orderWithNegativeQuantity.quantity = -40

    Given path '/store/order'
    And request orderWithNegativeQuantity
    When method post
    Then status 400


  Scenario: Placing an order with malformed JSON
    Given path '/store/order'
    And header Content-Type = 'application/json'
    And request '{"id": 99, "petId" '
    When method post
    Then status 400


  Scenario: Placing an order with invalid data types
    * def orderWithInvalidDataTypes = JSON.parse(JSON.stringify(validOrder))
    * set orderWithInvalidDataTypes.quantity = "hello"
    * set orderWithInvalidDataTypes.petId = true

    Given path '/store/order'
    And request orderWithInvalidDataTypes
    When method post
    Then status 400


  Scenario: Placing and order for a non existing pet
    * def orderWithNonExistingPetID = JSON.parse(JSON.stringify(validOrder))
    * set orderWithNonExistingPetID.petId = 12

    # Delete the pet
    Given path '/pet/delete/12'

    Given path '/store/order'
    And request orderWithNonExistingPetID
    When method post
    Then status 404

  Scenario: Placing an order with and ID that already exists
    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200

    Given path '/store/order'
    And request validOrder
    When method post
    Then status 200
    # Logical Response should be 409 for conflict
    # But the backend allows duplicates


  Scenario: Placing an order with extra fields
    * def orderWithExtraFeature = JSON.parse(JSON.stringify(validOrder))
    * set orderWithExtraFeature.color = "red"
    Given path '/store/order'
    And request orderWithExtraFeature
    When method post
    Then status 200

  Scenario: Placing an order with empty JSON
    Given path '/store/order'
    And header Content-Type = 'application/json'
    And request '{}'
    When method post
    Then status 400




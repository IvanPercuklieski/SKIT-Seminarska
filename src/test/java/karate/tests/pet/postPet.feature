Feature: Add a new pet to the store

  Background:
    * url 'https://petstore.swagger.io/v2'


  Scenario: Add a new pet to the store
    Given path 'pet'
    And request { "id": 4, "name": "Lali", "status": "available" }
    When method post
    Then status 200
    And match response.name == 'Lali'
    And match response.status == 'available'


  Scenario: Add a new pet to the store 2
    Given path 'pet'
    And request { "id": 5, "name": "Mimi", "status": "available" }
    When method post
    Then status 200
    And match response.name == 'Mimi'
    And match response.status == 'available'

  Scenario: Add a new pet to the store 2
    Given path 'pet'
    And request { "id": 14, "name": "Mimi", "status": "available" }
    When method post
    Then status 200
    And match response.name == 'Mimi'
    And match response.status == 'available'


  Scenario: Add a pet with invalid JSON
    Given path 'pet'
    And request { "id": "not-a-number" , "name": "Fluffy", "breed": "Poodle", "age": 3  }
    When method post
    Then status 500
    And match response.message == 'something bad happened'



  Scenario: Add a pet with invalid JSON
    Given path 'pet'
    And request { "id": not-a-number , "name": 123, "breed": "Poodle", "age": 3  }
    When method post
    Then status 500
    And match response.message == 'something bad happened'



  Scenario: Add a pet without providing an id, and the API assigns a default id
    Given path 'pet'
    And request { "name": "Fluffy", "status": "available" }
    When method post
    Then status 200
    And match response.name == 'Fluffy'
    And match response.status == 'available'
    And assert response.id != null

  Scenario: Add a pet without providing anything
    Given path 'pet'
    And request { }
    When method post
    Then status 200
    And assert response.id != null






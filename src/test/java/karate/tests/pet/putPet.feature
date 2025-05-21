Feature: Update an existing pet


  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario:Update a pet by providing an id
    Given path 'pet'
    And request {"id": 123,"category": {"id": 2,"name": "Cat"},"name": "Mimi Updated","photoUrls": ["http://example.com/photo1.jpg"],"tags": [{"id": 1,"name": "Angry"}],"status": "pending"  }
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And match response.id == 123
    And match response.name == 'Mimi Updated'
    And match response.status == 'pending'

  Scenario: Updating a pet with invalid id
    Given path 'pet'
    And request {"id":'abc', "category":{"id":1,"name":"Dog"},"name":"Sumo", "status":"sold"}
    And header Content-Type = "application/json"
    When method put
    Then status  500
    And match response.message == "something bad happened"

  Scenario: Updating a pet with invalid id 2
    Given path 'pet'
    And request {"id":-10, "name":"Verica", "status":"sold"}
    And header Content-Type = "application/json"
    When method put
    Then status  200
    And print 'Even if the id is invalid, the pet will be created using random generated Id'



  Scenario: Updating a pet with invalid request body
    Given path 'pet'
    And request { "id": 123, "category": {"id":1, "name":"Dog"},"name":"Lali with Inavlid Status","status":"invalid"}
    And header Content-Type = 'application/json'
    When method put
    Then status 200
    And print 'The request body is invalid, the pet is updated'

  Scenario: Updating a pet with only name
    Given path 'pet'
    And request { "name":"Ara"}
    And header Content-Type = 'application/json'
    When method put
    Then status 200


  Scenario: Updating a pet, on a way that is invalid
    Given path 'pet'
    And request { "id":"","name":100,"sttaus":""}
    When method put
    Then status 200



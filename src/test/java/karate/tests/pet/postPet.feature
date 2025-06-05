
Feature: Add a new pet to the store (POST /pet)



  Background:
    * url petstoreUrl




Scenario: Add a new pet with valid JSON

    * def id = getRandomValue()
    * def body =  {id: '#(id)', category: {id: 0,name: 'dogs'},name: 'Milo',photoUrls: ['http://example.com/dog.jpg'],tags: [{id: 0,name: 'friendly'}],status: 'available'}

    Given path 'pet'
    And request body
    When method post
    Then status 200
    And match response.id == id



  Scenario: Add pet with unknown/invalid field
    * def body = {"invalidField" : "oops"}
    Given path 'pet'
    And request body
    When method post
    Then status 400

  Scenario: POST with invalid Content-Type
    * header Content-Type = 'text/plain'
    Given path 'pet'
    And request 'id=1&name=BadFormat'
    When method post
    Then status 415




  Scenario: Add pet with invalid ID (non-numeric)
    * def body = { "id": "abc", "name": "Rex" }
    Given path 'pet'
    And request body
    When method post
    Then status 400


  Scenario:  Add pet with empty ID
    * def body = { "id": "" }
    Given path 'pet'
    And request body
    When method post
    Then status 400


  Scenario: Add pet with only one parameter
    * def body = { "name": "Fluffy" }
    Given path 'pet'
    And request body
    When method post
    Then status 400


  Scenario: Add pet with no parameters
    Given path 'pet'
    And request {}
    When method post
    Then status 400

  Scenario: Create pet with duplicate ID
    * def duplicateId = getRandomValue()
    * def pet = {id: '#(duplicateId)',name: "OriginalPet",photoUrls: ["http://example.com/photo.jpg"],status: "available"}

    Given path 'pet'
    And request pet
    When method post
    Then status 200

    # Try to create the same pet again
    Given path 'pet'
    And request pet
    When method post
    Then status 409
    #409 - Conflict


  Scenario: Create pet with null nested fields
    * def id = getRandomValue()
    * def pet = {id: '#(id)',name: "NullNestedPet",photoUrls: null,category: null,status: "available"}

    Given path 'pet'
    And request pet
    When method post
    Then status 400









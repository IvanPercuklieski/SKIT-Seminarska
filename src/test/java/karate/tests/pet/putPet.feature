
Feature: Update pets (PUT /pet)


  Background:
    * url petstoreUrl
    * header Content-Type = 'application/json'






  Scenario: Update pet with valid ID
    * def id = getRandomValue()
    * def pet = { id: '#(id)', name: 'OldName', status: 'available', photoUrls: ['http://example.com/img.jpg'] }
    Given path 'pet'
    And request pet
    When method put
    Then status 200

  Scenario: Update pet with non-existent ID

    * def body = { "id": 0, "name": "Ghost" }
    Given path 'pet'
    And request body
    When method put
    Then status 404

  Scenario: Update pet using only name (invalid)
    * def body = { "name": "OnlyName" }
    Given path 'pet'
    And request body
    When method put
    Then status 400



  Scenario: Update pet with unknown/extra fields
    * def id = getRandomValue()
    * def body = { "id": '#(id)', "name": "Extra", "extraField": "ignored" }
    Given path 'pet'
    And request body
    When method put
    Then status 400




  Scenario: PUT with max long ID
    * def body = { "id": 9223372036854775807, "name": "MaxInt" }
    Given path 'pet'
    And request body
    When method put
    Then status 200

  Scenario: PUT with max long ID + 1
    * def body = { "id": 9223372036854775808, "name": "MaxInt" }
    Given path 'pet'
    And request body
    When method put
    Then status 400

  Scenario: PUT with negative ID
    * def body = { "id": -1, "name": "MaxInt" }
    Given path 'pet'
    And request body
    When method put
    Then status 400


  Scenario: PUT with null ID
    * def body = { "id": null, "name": "NullId" }
    Given path 'pet'
    And request body
    When method put
    Then status 400

  Scenario: PUT with empty object
    Given path 'pet'
    And request {}
    When method put
    Then status 400

  Scenario: PUT with string
    * def body = { "id": 'abc', "name": "String" }
    Given path 'pet'
    And request body
    When method put
    Then status 400

  Scenario: Update pet with missing status and photoUrls
    * def id = getRandomValue()
    * def body = { id: '#(id)', name: 'NoStatusOrPhotos' }
    Given path 'pet'
    And request body
    When method put
    Then status 400






Feature: Find pets by ID (GET /pet/{id})
  Background:
    * url petstoreUrl

  Scenario: Create then get pet by ID
    * configure headers = { 'Content-Type': 'application/json' }
    * def id = getRandomValue()




    Given path 'pet',id
    When method get
    Then status 200




  Scenario: Get pet by string ID
    * def petId = 'abc'
    Given path 'pet', 'abc'
    When method get
    Then status 400


  Scenario:  Get pet with negative ID
    * def petId = -1
    Given path 'pet', -1
    When method get
    Then status 404

  Scenario:  Get pet with null ID

    Given path 'pet', null
    When method get
    Then status 400

  Scenario:  Get pet with empty pet ID
    * def petId = ''
    Given path 'pet', ''
    When method get
    Then status 400

  Scenario: Get pet with decimal ID
    Given path 'pet', 123.45
    When method get
    Then status 400




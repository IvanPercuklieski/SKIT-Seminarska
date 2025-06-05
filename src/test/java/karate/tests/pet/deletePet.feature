
Feature: Delete pets (DELETE /pet/{id})

  Background:
    * url petstoreUrl
    * header api_key = apiKey
    * header Content-Type = 'application/json'
    * def idd = getRandomValue()

  Scenario: Delete pet by valid ID

    Given path 'pet', idd
    When method delete
    Then status 200

  Scenario: Delete pet already deleted
    * def petId = idd
    Given path 'pet', petId

    When method delete
    Then status 404



  Scenario:  Delete pet without API key
    * configure headers = { 'Content-Type': 'application/json' }

    * def id = getRandomValue()

    Given path 'pet', id
    When method delete
    Then status 401

  Scenario: DELETE same pet twice (idempotency)

    * def id = getRandomValue()
    * def pet = { "id": '#(id)', "name": "ToDelete", "status": "available" }
    Given path 'pet'
    And request pet
    When method post
    Then status 200
    Given path 'pet', id
    When method delete
    Then status 200
    Given path 'pet', id
    When method delete
    Then status 404

  Scenario: Delete pet by invalid ID
    * def petId = null
    Given path 'pet', null
    When method delete
    Then status 400


  Scenario: Delete pet with empty ID
    * def petId = ''
    Given path 'pet', ''
    When method delete
    Then status 400

  Scenario: Delete pet by negative ID
    * def petId = -5
    Given path 'pet', -5
    When method delete
    Then status 400

  Scenario: Delete pet by string ID
    Given path 'pet', 'abc'
    When method delete
    Then status 400

  Scenario: Delete pet with very large ID
    Given path 'pet', 9223372036854775807
    When method delete
    Then status 404



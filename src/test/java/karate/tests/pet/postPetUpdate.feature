
Feature:  Update pet using form (POST /pet/{id})
  Background:
    * url petstoreUrl


  Scenario: Update pet with valid form
    * def id = getRandomValue()
    * def newPet = { id: '#(id)', name: 'TempPet', status: 'sold', photoUrls: ['http://example.com/valid.jpg'] }


    Given path 'pet'
    And request newPet
    When method post
    Then status 200


    Given path 'pet', id
    And header Content-Type = 'application/x-www-form-urlencoded'

    And form field name = 'Fluffy'
    And form field status = 'available'
    When method post
    Then status 200



  Scenario: Update a pet with non-existent ID
    * def petId = 0
    Given path 'pet', petId

    And form field name = 'Stella'
    And form field status = 'available'
    When method post
    Then status 404

    And print response


  Scenario: Update a pet with invalid form data
    Given path 'pet', 14
    And form field name = ''
    And form field status = ''
    When method post

    Then status 400


  Scenario:  Update a pet with empty form fields

    * def id = getRandomValue()
    * def newPet = { id: '#(id)', name: 'ToBeBlanked', status: 'pending', photoUrls: ['http://example.com/blank.jpg'] }
    Given path 'pet'
    And request newPet
    When method post
    Then status 200

    Given path 'pet', id
    And form field name = ''
    And form field status = ''
    When method post
    Then status 400



  Scenario: Update pet with invalid string ID
    Given path 'pet', 'abc'
    And form field name = 'Whatever'
    And form field status = 'pending'
    When method post
    Then status 400





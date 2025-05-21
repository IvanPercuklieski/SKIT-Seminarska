Feature: Updates a pet in the store with form data
  Background:
    * url 'https://petstore.swagger.io/v2'
  Scenario:Update an existing pet's name and status using form data
    Given path 'pet', 4
    And form field name = 'Fluffy'
    And form field status = 'available'
    When method post
    Then status 200
    And print 'Updated the status of the pet'

  Scenario: Update a pet with invalid data
    Given path 'pet', 999999999
    And form field name = 'Stella'
    And form field status = 'available'
    When method post
    Then status 404
    And match response.message == 'not found'

  Scenario: Update a pet with invalid form data
    Given path 'pet', 14
    And form field name = ''
    And form field status = ''
    When method post
    Then status 200
    And print 'Updated a pet, with invalid form data'

  Scenario: Update a pet with invalid id, that is string
    Given path 'pet', 'abc'
    And form field name = ''
    And form field status = ''
    When method post
    Then status 404
    And print 'The provided Id is string'



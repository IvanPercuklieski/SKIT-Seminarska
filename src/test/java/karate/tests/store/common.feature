Feature: Common utils

  Background:
    * def baseUrl =  'https://petstore.swagger.io/v2'

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


  Scenario: Get utils


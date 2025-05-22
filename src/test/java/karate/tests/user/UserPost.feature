Feature: Create user via POST /user endpoint

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

  Scenario: Create user with all valid fields
    Given request
      """
      {
        "id": 101,
        "username": "bojana_test",
        "firstName": "Bojana",
        "lastName": "Andonova",
        "email": "bojana@example.com",
        "password": "pass123",
        "phone": "070123456",
        "userStatus": 1
      }
      """
    When method post
    Then status 200

  Scenario: Create user without ID field
    Given request
      """
      {
        "username": "noIdUser",
        "password": "nopass123",
        "email": "test@example.com"
      }
      """
    When method post
    Then status 200

  Scenario: Create user with missing password
    Given request
      """
      {
        "id": 102,
        "username": "ana_nopass",
        "firstName": "Ana",
        "lastName": "Jovanovska",
        "email": "ana@example.com",
        "phone": "070000000",
        "userStatus": 1
      }
      """
    When method post
    Then status 400

  Scenario: Create user with missing username
    Given request
      """
      {
        "id": 103,
        "firstName": "Marko",
        "lastName": "Jovanovski",
        "email": "marko@example.com",
        "password" : "pass123",
        "phone": "070000000",
        "userStatus": 1
      }
      """
    When method post
    Then status 400

  Scenario: Create user with only username field
    Given request
      """
      {
        "username": "onlyUsername"
      }
      """
    When method post
    Then status 400

  Scenario: Create user with string instead of numeric ID
    Given request
      """
      {
        "id": "abc",
        "username": "Maja_invalid_type",
        "firstName": "Maja",
        "lastName": "Aleksova",
        "email": "maja@example.com",
        "password": "pass123",
        "phone": "070123456",
        "userStatus": 1,

      }
      """
    When method post
    Then status 400

  Scenario: Create user with empty string in password field
    Given request
      """
      {
        "id": 104,
        "username": "emptyPassUser",
        "firstName": "Martin",
        "lastName": "Popovski",
        "email": "martin@example.com",
        "password": "",
        "phone": "070123456",
        "userStatus": 1,
      }
      """
    When method post
    Then status 400

  Scenario: Create user with existing ID
    Given request
      """
      {
        "id": 101,
        "username": "marko_duplicateID",
        "firstName": "Marko",
        "lastName": "Petrov",
        "email": "marko@example.com",
        "password": "pass321",
        "phone": "071111111",
        "userStatus": 1
      }
      """
    When method post
    Then status 409

  Scenario: Create user with existing username
    Given request
      """
      {
        "id": 105,
        "username": "bojana_test",
        "firstName": "Bojana",
        "lastName": "Andonova",
        "email": "dupl@example.com",
        "password": "test123",
        "phone": "071000000",
        "userStatus": 1
      }
      """
    When method post
    Then status 409

  Scenario: Create user with empty body
    Given request {}
    When method post
    Then status 400


  #  Scenario: Create user with malformed JSON
  #    Given request
  #      """
  #      {
  #        "id": 999,
  #        "username": "badjson"
  #        "password": "test"
  #      }
  #      """
  #    When method post
  #    Then status 400

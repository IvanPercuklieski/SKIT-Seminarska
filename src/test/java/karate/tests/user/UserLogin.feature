Feature: User login via GET /user/login

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

    # Create user before each scenario
    * def userData =
      """
      {
        "id": 800,
        "username": "bojanaa",
        "firstName": "Bojana",
        "lastName": "Andonova",
        "email": "bojana@example.com",
        "password": "pass123",
        "phone": "070111222",
        "userStatus": 1
      }
      """
    Given path ''
    And request userData
    When method post
    Then status 200

  Scenario: Login with valid username and password
    Given path 'login'
    And param username = 'bojana_test'
    And param password = 'pass123'
    When method get
    Then status 200

  Scenario: Login with wrong password
    Given path 'login'
    And param username = 'bojana_test'
    And param password = 'wrongpass'
    When method get
    Then status 401


  Scenario: Login with missing password
    Given path 'login'
    And param username = 'bojana_test'
    When method get
    Then status 400

  Scenario: Login with missing username
    Given path 'login'
    And param password = 'pass123'
    When method get
    Then status 400

  Scenario: Login with empty credentials
    Given path 'login'
    And param username = ''
    And param password = ''
    When method get
    Then status 400




Feature: User logout via GET /user/logout

  Background:
    * call read('classpath:karate/tests/user/Setup.feature')

    # Create user before each scenario
    * def userData =
      """
      {
        "id": 900,
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

  Scenario: Logout after login
    # Simulation of the login step
    Given path 'login'
    And param username = 'bojanaa'
    And param password = 'pass123'
    When method get
    Then status 200

    Given path 'logout'
    When method get
    Then status 200

  Scenario: Logout without login
    Given path 'logout'
    When method get
    Then status 200

#    It returns 200 OK because there is no Authorization
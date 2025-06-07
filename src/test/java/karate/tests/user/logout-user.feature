Feature: User logout via GET /user/logout

  Background:
    * call read('common-user.feature')
    * def loginPath = 'login'
    * def logoutPath = 'logout'

    # Create user before each scenario
    Given path ''
    And request user_logout
    When method post

  Scenario: Logout after login
    # Simulation of the login
    Given path loginPath
    And param username = user_logout.username
    And param password = user_logout.password
    When method get
    Then status 200

    Given path logoutPath
    When method get
    Then status 200

  Scenario: Logout without login
    Given path logoutPath
    When method get
    Then status 200
    # It returns 200 OK because there is no Authorization


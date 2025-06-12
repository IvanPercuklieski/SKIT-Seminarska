Feature: User login via GET /user/login

  Background:
    * call read('common-user.feature')
    * def loginPath = 'login'

    # Create user before each scenario
    Given path ''
    And request user_login
    When method post
    Then status 200

  Scenario: Login with valid username and password
    Given path loginPath
    And param username = user_login.username
    And param password = user_login.password
    When method get
    Then status 200

  Scenario: Login with wrong password
    Given path loginPath
    And param username = user_login.username
    And param password = 'wrongpass'
    When method get
    Then status 401


  Scenario: Login with missing password
    Given path loginPath
    And param username = user_login.username
    When method get
    Then status 400

  Scenario: Login with missing username
    Given path loginPath
    And param password = user_login.password
    When method get
    Then status 400

  Scenario: Login with empty credentials
    Given path loginPath
    And param username = ''
    And param password = ''
    When method get
    Then status 400




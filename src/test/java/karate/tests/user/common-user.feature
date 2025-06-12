Feature: Common user test data and base URL

  Background:
    * configure url = 'https://petstore.swagger.io/v2/user'

    * def user_valid =
      """
      {
        "id": 100,
        "username": "user_valid",
        "firstName": "Bojana",
        "lastName": "Andonova",
        "email": "bojana@example.com",
        "password": "pass123",
        "phone": "070123456",
        "userStatus": 1
      }
      """

    * def user_missing_id =
      """
      {
        "username": "user_no_id",
        "firstName": "Missing",
        "lastName": "ID",
        "email": "user_no_id@example.com",
        "password": "pass1",
        "phone": "070000001",
        "userStatus": 1
      }
      """

    * def user_missing_password =
      """
      {
        "id": 102,
        "username": "user_no_pass",
        "firstName": "Missing",
        "lastName": "Passowrd",
        "email": "user_no_pass@example.com",
        "phone": "070000002",
        "userStatus": 1
      }
      """

    * def user_missing_username =
      """
      {
        "id": 103,
        "firstName": "Missing",
        "lastName": "Username",
        "email": "user_no_username@example.com",
        "password": "pass3",
        "phone": "070000003",
        "userStatus": 1
      }
      """

    * def user_only_username =
      """
      {
        "username": "user_only_username"
      }
      """

    * def user_invalid_id =
      """
      {
        "id": "abc",
        "username": "user_invalid_id",
        "firstName": "Invalid",
        "lastName": "ID",
        "email": "user_invalid@example.com",
        "password": "pass5",
        "phone": "070000005",
        "userStatus": 1
      }
      """

    * def user_empty_password =
      """
      {
        "id": 106,
        "username": "user_empty_password",
        "firstName": "Empty",
        "lastName": "Password",
        "email": "user_empty_pas@example.com",
        "password": "",
        "phone": "070000006",
        "userStatus": 1
      }
      """

    * def user_existing_id_1 =
      """
      {
        "id": 107,
        "username": "user_existing_id_1",
        "firstName": "Existing",
        "lastName": "ID",
        "email": "user_existing_id@example.com",
        "password": "pass7",
        "phone": "070000007",
        "userStatus": 1
      }
      """

    * def user_existing_id_2 =
      """
      {
        "id": 107,
        "username": "user_existing_id_2",
        "firstName": "Existing",
        "lastName": "ID",
        "email": "user_existing_id@example.com",
        "password": "pass7",
        "phone": "070000007",
        "userStatus": 1
      }
      """

    * def user_existing_username_1 =
      """
      {
        "id": 108,
        "username": "user_existing_username",
        "firstName": "Existing",
        "lastName": "Username",
        "email": "user_existing_username@example.com",
        "password": "pass8",
        "phone": "070000008",
        "userStatus": 1
      }
      """

    * def user_existing_username_2 =
      """
      {
        "id": 109,
        "username": "user_existing_username",
        "firstName": "Existing",
        "lastName": "Username",
        "email": "user_existing_username@example.com",
        "password": "pass9",
        "phone": "070000009",
        "userStatus": 1
      }
      """

    * def user_delete =
      """
      {
        "id": 110,
        "username": "user_delete",
        "firstName": "Deleting",
        "lastName": "User",
        "email": "user_delete@example.com",
        "password": "pass10",
        "phone": "070000010",
        "userStatus": 1
      }
      """

    * def user_login =
      """
      {
        "id": 111,
        "username": "user_login",
        "firstName": "User",
        "lastName": "Login Data",
        "email": "user_login@example.com",
        "password": "pass11",
        "phone": "070000011",
        "userStatus": 1
      }
      """

    * def user_logout =
      """
      {
        "id": 112,
        "username": "user_logout",
        "firstName": "User",
        "lastName": "Logout Data",
        "email": "user_logout@example.com",
        "password": "pass12",
        "phone": "070000012",
        "userStatus": 1
      }
      """

    * def user_get_valid =
      """
      {
        "id": 113,
        "username": "get_valid_user",
        "firstName": "Get",
        "lastName": "User",
        "email": "get_valid_user@example.com",
        "password": "pass13",
        "phone": "070000013",
        "userStatus": 1
      }
      """

    * def user_for_update =
      """
      {
        "id": 114,
        "username": "user_for_update",
        "firstName": "Update",
        "lastName": "User",
        "email": "user_for_update@example.com",
        "password": "pass14",
        "phone": "070000014",
        "userStatus": 1
      }
      """

    * def users_array =
      """
      [
        {
          "id": 115,
          "username": "array_user_1",
          "firstName": "User",
          "lastName": "One",
          "email": "user1@example.com",
          "password": "pass1",
          "phone": "070000015",
          "userStatus": 1
        },
        {
          "id": 116,
          "username": "array_user_2",
          "firstName": "User",
          "lastName": "Two",
          "email": "user2@example.com",
          "password": "pass2",
          "phone": "070000016",
          "userStatus": 1
        }
      ]
      """

    * def malformed_json_users_array = '[{ "id": 115, "username": "array_user_1", "firstName": "User", "lastName": "One", "email": "user1@example.com" "password": "pass1", "phone": "070000015", "userStatus": 1 }, { "id": 116, "username": "array_user_2", "firstName": "User", "lastName": "Two" "email": "user2@example.com", "password": "pass2", "phone": "070000016", "userStatus": 1 ]'

    * def users_list =
      """
      [
        {
          "id": 117,
          "username": "list_user_1",
          "firstName": "User",
          "lastName": "One",
          "email": "user1@example.com",
          "password": "pass1",
          "phone": "070000017",
          "userStatus": 1
        },
        {
          "id": 118,
          "username": "list_user_2",
          "firstName": "User",
          "lastName": "Two",
          "email": "user2@example.com",
          "password": "pass2",
          "phone": "070000018",
          "userStatus": 1
        }
      ]
      """

    * def malformed_json_users_list = '[{ "id": 117, "username": "list_user_1", "firstName": "User", "lastName": "One", "email": "user1@example.com" "password": "pass1", "phone": "070000017", "userStatus": 1 }, { "id": 118, "username": "list_user_2", "firstName": "User", "lastName": "Two" "email": "user2@example.com", "password": "pass2", "phone": "070000018", "userStatus": 1 ]'

    Scenario: Get data








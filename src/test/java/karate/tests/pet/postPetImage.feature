Feature: Uploading an image

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Upload image for a pet
    Given url 'https://petstore.swagger.io/v2/pet/4/uploadImage'
    And multipart file file = 'classpath:images/dog.jpg'
    And param additionalMetadata = 'This is a cute dog!'
    When method post
    Then status 200



  Scenario: Upload an image for a non-existent petId
    Given url 'https://petstore.swagger.io/v2/pet/999999999999/uploadImage'
    And multipart file file = 'classpath:images/dog.jpg'
    And param additionalMetadata = 'This is a cute dog!'
    When method post
    Then status 200




  Scenario: Attempt to upload an image without a file
    Given url 'https://petstore.swagger.io/v2/pet/8/uploadImage'
    And param additionalMetadata = 'This is a cute dog!'
    When method post
    Then status 415
    And print "Invalid picture upload"

  Scenario: Upload an image without additional metadata
    Given url 'https://petstore.swagger.io/v2/pet/11/uploadImage'
    And multipart file file = 'classpath:images/dog.jpg'
    When method post
    Then status 200

  Scenario: Upload an image with invalid id
    Given url 'https://petstore.swagger.io/v2/pet/abc/uploadImage'
    And multipart file file = 'classpath:images/dog.jpg'
    And param additionalMetadata = 'This is a cute dog!'
    When method post
    Then status 404
    And print "Invalid Id provided"
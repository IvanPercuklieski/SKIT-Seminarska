
Feature: Upload image for pet (POST /pet/{id}/uploadImage)

  Background:
    * url petstoreUrl

  Scenario: Upload valid image

    * def id = getRandomValue()
    * def pet = { id: '#(id)', name: 'ImagePet', status: 'available', photoUrls: ['http://example.com/photo.jpg'] }
    Given path 'pet'
    And request pet
    When method post
    Then status 200

    Given path 'pet', id, 'uploadImage'
    And multipart file file = { read: 'classpath:images/dog.jpg', filename: 'dog.jpg', contentType: 'image/jpeg' }
    And param additionalMetadata = 'Nice dog'

    When method post
    Then status 200




  Scenario: Upload image without file

    * def id = getRandomValue()
    * def pet = { id: '#(id)', name: 'ImagePet2', status: 'available', photoUrls: ['http://example.com/photo2.jpg'] }
    Given path 'pet'
    And request pet
    When method post
    Then status 200

    Given path 'pet', id, 'uploadImage'
    And param additionalMetadata = 'No file'
    When method post
    Then status 400





  Scenario:  Upload only metadata (invalid file type)

    * def id = getRandomValue()
    * def pet = { id: '#(id)', name: 'InvalidFilePet', status: 'available', photoUrls: [''] }
    Given path 'pet'
    And request pet
    When method post
    Then status 200

    Given path 'pet', id, 'uploadImage'
    And multipart file file = { content: 'This is some invalid file content', filename: 'invalid.txt', contentType: 'text/plain' }
    When method post
    Then status 415
    #415-Unsupported Media Type

  Scenario: Upload an image without additional metadata
    Given url 'https://petstore.swagger.io/v2/pet/11/uploadImage'
    And multipart file file = 'classpath:images/dog.jpg'
    When method post
    Then status 200



  Scenario: Upload image with non-existent ID


    Given path 'pet', 999999999, 'uploadImage'
    And multipart file file = { read: 'classpath:images/dog.jpg', filename: 'dog.jpg', contentType: 'image/jpeg' }
    When method post
    Then status 404

  Scenario: Upload image with non-string additionalMetadata
    * def idd = getRandomValue()
    * def pet = { id: '#(idd)', name: 'ImagePet', status: 'available', photoUrls: ['http://example.com'] }


    Given path 'pet'
    And request pet
    When method post
    Then status 200


    Given path 'pet', idd, 'uploadImage'
    And multipart file file = { read: 'classpath:images/dog.jpg', filename: 'dog.jpg', contentType: 'image/jpeg' }
    And param additionalMetadata = 12345
    When method post
    Then status 400



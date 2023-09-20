Feature: Read csv demo

  Background:
    * configure ssl = false

  Scenario Outline: GET request with CSV table - one column
    Given url 'https://reqres.in/api/users/'
    And path id
    When method GET
    * print 'Response: ', response
    Then status 200

    Examples:
      | read('classpath:data/read-data.csv') |

  Scenario Outline: GET request with CSV table - multiple column
    Given url 'https://reqres.in/api/users/'
    And path id
    When method GET
    * print 'User name: ', name
    * print 'Message: ', message
    * print 'Response: ', response
    Then status 200

    Examples:
      | read('classpath:data/read-data-multiple.csv') |

  Scenario Outline: GET request with CSV table - multiple column encode data
    * def util = Java.type('util.UtilClass')
    * print 'id: ', id
    * print 'dni: ', util.decodeB64(dni)
    * print 'name: ', name

    Examples:
      | read('classpath:data/read-data-multiple-encode.csv') |
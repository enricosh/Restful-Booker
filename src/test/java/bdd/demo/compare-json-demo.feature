Feature: Compare Json Demo

  Background:
    * configure ssl = false
    * url 'https://reqres.in'

  Scenario: compare if two json match - 1
    * def json1 = '{"name": "morpheus","job": "leader"}'
    * def json2 = '{"name": "neo","job": "leader"}'
    * match json1 contains json2

  Scenario: compare if two json match - 2
    * def json1 = '{"name": "morpheus","job": "leader"}'
    * def json2 = '{"name": "neo","job": "leader"}'
    * match json1 contains json2

  Scenario: compare if two json responses match - 3
    ###### Get user 1 ######
    Given path '/api/users/1'
    When method get
    Then status 200
    * def response_1 = response
    * print 'Response 1 :\n', response_1
    ###### Get user 2 ######
    Given path '/api/users/2'
    When method get
    Then status 200
    * def response_2 = response
    * print 'Response 2 :\n', response_2
    ###### compare both answers ######
    * match response_1 == response_2

  Scenario: validate schema - 4
    Given def json =
    """
    {
    "data": {
        "id": 2,
        "email": "janet.weaver@reqres.in",
        "first_name": "Janet",
        "last_name": "Weaver",
        "avatar": "https://reqres.in/img/faces/2-image.jpg"
    },
    "support": {
        "url": "https://reqres.in/#support-heading",
        "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
      }
    }
    """
    * print 'json: \n', json
    * def schema =
    """
    {
     data: {
        email: '#string',
        id: '#number',
        first_name: '#string',
        last_name: '#string',
        avatar: '#string',
     },
     support: {
        url: '#string',
        text: '#string'
     }
    }
    """
    Then match json contains schema

  Scenario: validate schema from file - 4
    Given def json = read('classpath:req/req-to-validate.json')
    * print 'json: \n', json
    * def schema = read('classpath:schema/sch-req-to-validate.json')
    Then match json contains schema


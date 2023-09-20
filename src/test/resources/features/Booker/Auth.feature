@tokenBooker
Feature: token

Background:
  * url domainToken
  * path '/auth'
  * headers {'http-method':'POST','Content-Type':'application/json','Accept':'application/json'}

@Scenario_Login_OK
    Scenario Outline:Obtener token
    Given request {'username': <user>,'password':<pass>}
    When method POST
    Then status 200
    And assert responseTime < 2000
    And def authToken = response
    And match response.token contains '#notnull'
    And print 'Se capturo el token: ', authToken

    Examples:
    | user      | pass          |
    | 'admin'   | 'password123' |


@Scenario_NO_OK
    Scenario Outline:Password invalido
        Given request {'username': <user>,'password':<pass>}
        When method POST
        Then status 200
        And assert responseTime < 2000
        And def authToken = response
        And match response.reason contains '#notnull'
        And print 'Se capturo respuesta: ', authToken

    Examples:
    | user      | pass          |
    | 'admin'   | 'password000' |

@Scenario_NO_OK
    Scenario Outline:Usuario invalido
        Given request {'username': <user>,'password':<pass>}
        When method POST
        Then status 200
        And assert responseTime < 2000
        And def authToken = response
        And match response.reason contains '#notnull'
        And print 'Se capturo respuesta: ', authToken

    Examples:
    | user      | pass          |
    | 'jhony'   | 'password123' |

@Scenario_NO_OK
    Scenario Outline:Password vacio
        Given request {'username': <user>,'password':<pass>}
        When method POST
        Then status 200
        And assert responseTime < 2000
        And def authToken = response
        And match response.reason contains '#notnull'
        And print 'Se capturo respuesta: ', authToken

    Examples:
   | user      | pass        |
   | 'jhony'   | ''          |

@Scenario_NO_OK
    Scenario Outline:Usuario vacio
        Given request {'username': <user>,'password':<pass>}
        When method POST
        Then status 200
        And assert responseTime < 2000
        And def authToken = response
        And match response.reason contains '#notnull'
        And print 'Se capturo respuesta: ', authToken

    Examples:
    | user    | pass        |
    | ''      | password123 |
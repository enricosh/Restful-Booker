@pingBooker
Feature: ping

  Background:
    * url domainToken
    * path '/ping'
    #* headers {'http-method':'POST','Content-Type':'application/json','Accept':'application/json'}

  @Scenario_OK
  Scenario: Validar ping
    When method GET
    Then status 201
    And assert responseTime < 4000
    And def ping = response
    And match response contains 'Created'
    And print 'Se capturo respuesta: ', ping


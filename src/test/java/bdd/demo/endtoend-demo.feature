Feature: Users

  Background:
    * configure ssl = false
    * url 'https://reqres.in'

  Scenario: create and update a user
    ###### Crear usuario ######
    Given path '/api/users'
    And request '{"name": "morpheus","job": "leader"}'
    When method post
    #imprime la url final
    * print 'headers: ',karate.prevRequest.url
    #imprime las cabeceras
    * print 'headers: ',karate.prevRequest.headers
    #imprime body request
    * print 'body: ',karate.prevRequest.body
    #imprime el metodo enviado
    * print 'method: ',karate.prevRequest.method
    Then status 201
    * print 'Response :\n', response
    * def id = response.id
    * print 'id new user: ', id
    ###### Actualizar usuario ######
    Given path '/api/users/'+ id
    And request '{"name": "Percy","job": "QE"}'
    When method put
    #imprime la url final
    * print 'headers: ',karate.prevRequest.url
    #imprime las cabeceras
    * print 'headers: ',karate.prevRequest.headers
    #imprime body request
    * print 'body: ',karate.prevRequest.body
    #imprime el metodo enviado
    * print 'method: ',karate.prevRequest.method
    Then status 200
    * print 'Response :\n', response
    * def date = response.updatedAt
    * match date contains '2023-05-24'

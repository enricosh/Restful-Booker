#language: es
@INCTTC-3124
Feature: Default


  @INCTTC-3120 @demo2.feature
  Scenario Outline: Generar access token
    Given url baseURL
    And form field grant_type = 'client_credentials'
    And form field client_id = inct_test_ciam_token_client_id
    And form field client_secret = inct_test_ciam_token_client_secret
    And form field scope = 'channel.mbbk.default ciamux'
    When method post
    Then status <codes>
    And match $.access_token contains '#notnull'
    And match $.access_token contains '#string'
    And def authToken = response.access_token;
    And print 'Se guarda: ' ,authToken

    Examples:
      | codes |
      | 200   |


  @INCTTC-3121 @demo2.feature
  Scenario: Obtener lista de usuarios
    Given url 'https://reqres.in/api/users'
    When method GET
    Then status 200
    And match response.data[*].id == '#[] #number'


  @INCTTC-3122 @demo2.feature
  Scenario: Crear nuevo usuario
    Given url 'https://reqres.in/api/users'
    And request { "name": "John Doe", "job": "Tester" }
    When method POST
    Then status 201
    And match response.name == 'John Doe'


  @INCTTC-3123 @demo2.feature
  Scenario: Iniciar sesión
    Given url 'https://reqres.in/api/login'
    And request { "email": "eve.holt@reqres.in", "password": "cityslicka" }
    When method POST
    Then status 200
    And match response.token == 'QpwL5tke4Pnpja7X4'
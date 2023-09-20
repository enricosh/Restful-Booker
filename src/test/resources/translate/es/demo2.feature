#language: es
@INCTTC-3124
Característica: Default


@INCTTC-3120 @demo2.feature
Esquema del escenario: Generar access token
Dado url baseURL
Y form field grant_type = 'client_credentials'
Y form field client_id = inct_test_ciam_token_client_id
Y form field client_secret = inct_test_ciam_token_client_secret
Y form field scope = 'channel.mbbk.default ciamux'
Cuando method post
Entonces status <codes>
Y match $.access_token contains '#notnull'
Y match $.access_token contains '#string'
Y def authToken = response.access_token;
Y print 'Se guarda: ' ,authToken

Ejemplos:
| codes |
| 200   |


@INCTTC-3121 @demo2.feature
Escenario: Obtener lista de usuarios
Dado url 'https://reqres.in/api/users'
Cuando method GET
Entonces status 200
Y match response.data[*].id == '#[] #number'


@INCTTC-3122 @demo2.feature
Escenario: Crear nuevo usuario
Dado url 'https://reqres.in/api/users'
Y request { "name": "John Doe", "job": "Tester" }
Cuando method POST
Entonces status 201
Y match response.name == 'John Doe'


@INCTTC-3123 @demo2.feature
Escenario: Iniciar sesión
Dado url 'https://reqres.in/api/login'
Y request { "email": "eve.holt@reqres.in", "password": "cityslicka" }
Cuando method POST
Entonces status 200
Y match response.token == 'QpwL5tke4Pnpja7X4'
@bookingBooker
Feature: booking

  Background:
    * url domainToken
    * path '/booking'
    * def token = call read('Auth.feature@Scenario_Login_OK')

  @Scenario_BookingIds_OK
  Scenario: Obtener todos los ids
    Given  headers {'http-method':'GET','Content-Type':'application/json','Accept':'application/json'}
    When method GET
    Then status 200
    And assert responseTime < 2000
    And print 'Se capturo respuesta: ', response


  @Scenario_BookingIds_OK
  Scenario Outline: Obtener ids filtrando nombres
    Given  headers {'http-method':'GET','Content-Type':'application/json','Accept':'application/json'}
    And param firstname = <firstname>
    And param lastname = <lastname>
    When method GET
    Then status 200
    And assert responseTime < 2000
    And print 'Se capturo respuesta: ', response

    Examples:
     | firstname | lastname      |
     | 'Enrico'  | 'Salcedo'     |

  @Scenario_BookingIds_OK
  Scenario Outline: Obtener ids filtrando fechas
    Given  headers {'http-method':'GET','Content-Type':'application/json','Accept':'application/json'}
    And param checkin = <checkin>
    And param checkout = <checkout>
    When method GET
    Then status 200
    And assert responseTime < 2000
    And print 'Se capturo respuesta: ', response

    Examples:
      | checkin       | checkout          |
      | '2018-01-01'  | '2019-01-01'      |

  @Scenario_Booking_OK
  Scenario Outline: Obtener booking
    Given  headers {'http-method':'GET','Content-Type':'application/json','Accept':'application/json'}
    And path <bookingid>
    When method GET
    Then status 200
    And assert responseTime < 2000
    And print 'Se capturo respuesta: ', response

    Examples:
      | bookingid  |
      | 189        |

  @Scenario_Create_OK
  Scenario: Crear booking
    Given  headers {'http-method':'POST','Content-Type':'application/json','Accept':'application/json'}
    And request { firstname : 'Enrico',lastname : 'Salcedo',totalprice : 111,depositpaid : true,bookingdates : {checkin : '2018-01-01',checkout : '2019-01-01'},additionalneeds : 'Breakfast'}
    When method POST
    Then status 200
    And assert responseTime < 2000
    And match response.bookingid != 0
    And print 'Se capturo respuesta: ', response


  @Scenario_Update_OK
  Scenario Outline: Update booking
    Given  headers {'http-method':'PUT','Content-Type':'application/json','Accept':'application/json'}
    * def token2 = 'YWRtaW46cGFzc3dvcmQxMjM='
    And header Authorization = 'Basic ' + token2
    And path <bookingid>
    And request { firstname : 'Renato',lastname : 'Salcedo',totalprice : 111,depositpaid : true,bookingdates : {checkin : '2018-01-01',checkout : '2019-01-01'},additionalneeds : 'Breakfast'}
    When method PUT
    Then status 200
    And assert responseTime < 2000
    And match response == { firstname : 'Renato',lastname : 'Salcedo',totalprice : 111,depositpaid : true,bookingdates : {checkin : '2018-01-01',checkout : '2019-01-01'},additionalneeds : 'Breakfast'}
    And print 'Se capturo respuesta: ', response

    Examples:
      | bookingid  |
      | 10576      |


  @Scenario_PartialUpdate_OK
  Scenario Outline: Partial Update booking
    Given  headers {'http-method':'PATCH','Content-Type':'application/json','Accept':'application/json'}
    * def token2 = 'YWRtaW46cGFzc3dvcmQxMjM='
    And header Authorization = 'Basic ' + token2
    And path <bookingid>
    And request { firstname : 'Dante',lastname : 'Jimenez'}
    When method PATCH
    Then status 200
    And assert responseTime < 2000
    And match response.firstname == 'Dante'
    And match response.lastname == 'Jimenez'
    And print 'Se capturo respuesta: ', response

    Examples:
      | bookingid  |
      | 2491       |

  @Scenario_Delete_OK
  Scenario Outline: Delete booking
    * def token2 = token.authToken
    Given  headers {'http-method':'DELETE','Content-Type':'application/json','Accept':'application/json'}
    And header Cookie = 'token=' + token2.token
    And path <bookingid>
    When method DELETE
    Then status 201
    And assert responseTime < 2000
    And match response == 'Created'
    And print 'Se capturo respuesta: ', response

    Examples:
      | bookingid  |
      | 2714       |
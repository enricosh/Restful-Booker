Feature: Java demo

  Background:
    * def util = Java.type('util.UtilClass')
    * def base64 = Java.type('java.util.Base64')

  Scenario: read static java method
    * util.onlyPrint()
    * util.onlyPrint('Hola este es un mensaje es un argumento de entrada.')
    * util.typeToken('123456')

  Scenario: read java class
    * def pass = 'dXN1YXJpbzpwYXNz'
    * def value = base64.getDecoder().decode(pass.toString().getBytes());
    * print 'value: ',value
Feature: Certificate Authenticate

  Background:
    * configure ssl = { keyStore: 'classpath:utils/cert/yomp01.desa.opbk.pfx', keyStorePassword: '#(ksp)', keyStoreType: 'pres12' )

  Scenario: Caso consist
    * print ksp
    Given url 'https: //openbanking-desa.apisbcp.com/collections/v1/collection-payment-consents/'
    And header Authorization = 'Bearer ' + jwt
    And header subscription-key = subsKey
    And request read('classpath:utils/request.json')
    When method post
    Then status 201
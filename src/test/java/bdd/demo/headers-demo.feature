Feature: Read headers from json

  Background:
    * def headers = read('classpath:req/head-api-v1.json')

  Scenario: print headers from json
    * print 'current headers: \n', headers

  Scenario: update headers from json
    * print 'current headers: \n', headers
    * set headers.Authorization = 'Bearer saknsjdnajsndjnjn1jn2j3n123n12j3njinasjidnaisjndijasdsaknsjdnajsndjnjn1jn2j3n123n12j3njinasjidnaisjndijasdsaknsjdnajsndjnjn1jn2j3n123n12j3njinasjidnaisjndijasd'
    * set headers.subscription = '000000000111111'
    * print 'updated headers: \n', headers

  @web-api
  Scenario: update headers with value from a feature
    * def webNegocio = call read('classpath:bdd/demo/casoreal-webNegocio-token.feature')
    * print 'webNegocio: ', webNegocio.codeOC
    * print 'current headers: \n', headers
    * set headers.Authorization = 'Bearer saknsjdnajsndjnjn1jn2j3n123n12j3njinasjidnaisjndijasd'
    * set headers.subscription = '000000000111111'
    * set headers.codeOC = webNegocio.codeOC
    * print 'updated headers: \n', headers
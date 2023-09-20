Feature: WEB

  Background:
    * def util = Java.type('util.UtilClass')
    * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*"] }

  Scenario: caso1- abrir web
    Given driver authUrl
    * driver.maximize()
    * retry(10).waitForUrl("/loginunicocert.viabcp.com")
    * retry(10).waitFor("input[placeholder='Nro de documento']")
    * delay(2000)
    * click("input[placeholder='Nro de documento']")
    * input("input[placeholder='Nro de documento']",'23237271')
    #metodo customizado para ingresar datos con un tiempo intercalado de 500 mill
    * util.lazyInput(driver,'bcp-captcha input','secret')
    * delay(500)
    * click('button.btn-primary')
    * retry(10).waitFor('ciam-card-option bcp-card bcp-button')
    * click('ciam-card-option bcp-card bcp-button')
    * delay(5000)
    * clear('input[name=ciam-input-card]')
    * input('input[name=ciam-input-card]','4557885801979322')
    * retry(10).waitFor('bcp-input-password')
    * delay(1000)
    * mouse('bcp-input-password').click()
    * delay(3000)
    * util.typeToken(driver, '111111')
    * delay(1000)
    * click('form div.button-space-bottom bcp-button button')
    * retry(10).waitForUrl("/auth/logged?")
    * def currentURL = driver.url
    * print 'CurrentUrl: ', currentURL
    * def codeOC = currentURL.substring(currentURL.indexOf("code=") + 5, currentURL.indexOf("&state"));
    * print 'codeOC: ', codeOC
    * quit()



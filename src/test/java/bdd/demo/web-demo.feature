Feature: Web Demo

  Background:
    * configure driver = { type: 'chrome', addOptions: ["--remote-allow-origins=*"] }

  Scenario: login saucedemo
    Given driver 'https://www.saucedemo.com/'
    * driver.maximize()
    When input("input#user-name", 'standard_user')
    And input("input#password", 'secret_sauce')
    And click("input#login-button")
    Then def title = text('div.header_label div')
    * print 'Title: ', title
    And match title == "Swag Labs"

    Scenario: search google settings
      Given driver 'chrome://settings/'
      * driver.maximize()
      When script("document.querySelector('body > settings-ui').shadowRoot.querySelector('#leftMenu').shadowRoot.querySelector('#menu > a:nth-child(3)').click()")
      When def title = script("document.querySelector('body > settings-ui').shadowRoot.querySelector('#main').shadowRoot.querySelector('settings-basic-page').shadowRoot.querySelector('#safetyCheckSettingsSection').shadowRoot.querySelector('#title').innerText")
      * print 'title: ', title
      Then match title == 'Comprobación de seguridad'
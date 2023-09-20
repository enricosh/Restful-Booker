Feature: DB Connection

  Background:
# Create JDBC connection with DbUtils java class
    And def config = { username: 'root', password: 'root', url: 'jdbc:mysql://localhost:3306/sample_db', driverClassName: 'com.mysql.cj.jdbc.Driver' }
    And def DbUtils = Java.type('util.DbUtils')
    And def db = new DbUtils(config)

  Scenario: database connection
    And def query = "select * from test_table where id = '1'"
    And def dbResult = db.readRow(query)
    And print dbResult
    And match dbResult.name contains test_name



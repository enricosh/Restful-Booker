Feature: Write data into a CSV file

  Scenario: caso
    * json list = [{"id":"1", "name":"Percy"}, {"id":"2", "name": "Rossana"}, {"id":"3", "name": "Daniel"}, {"id":"4", "name": "Abraham"}]
    * def csv = karate.toCsv(list)
    * print 'csv: ',csv
    * karate.write(csv, 'data/demo.csv')
    * def count = db.readRow(query)
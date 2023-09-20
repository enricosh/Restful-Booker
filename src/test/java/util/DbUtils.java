package util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import java.util.List;
import java.util.Map;

public class DbUtils {

    private static final Logger logger = LoggerFactory.getLogger(DbUtils.class);
    private final JdbcTemplate jdbc;

    public DbUtils(Map<String, Object> config) {
        String url = (String) config.get("url");
        String username = (String) config.get("username");
        String password = (String) config.get("password");
        String driver = (String) config.get("driverClassName");
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(driver);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        jdbc = new JdbcTemplate(dataSource);
        logger.info("init jdbc template: {}", url);
    }

    // SELECT statement: Return single value from the database
    public Object readValue(String query) {
        return jdbc.queryForObject(query, Object.class);
    }

    // SELECT statement: Returns one row from a table
    public Map<String, Object> readRow(String query) {
        return jdbc.queryForMap(query);
    }

    // SELECT statement: Returns multiple rows from a data table
    public List<Map<String, Object>> readRows(String query) {
        return jdbc.queryForList(query);
    }

    // UPDATE RECORD of a table
    public String update(String query) {
        int count = jdbc.update(query);
        return "Record updated successfully : " + count;
    }

    // DELETE RECORD of a table
    public String delete(Integer id, String query) {
        int count = jdbc.update(query, id);
        return "Number of records deleted : " + count;
    }
}


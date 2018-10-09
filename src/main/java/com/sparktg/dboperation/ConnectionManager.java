package com.sparktg.dboperation;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConnectionManager {
    private static Logger log = LoggerFactory.getLogger(ConnectionManager.class);
    private static final String PROP_FILE = "/connection_config.properties";
    private static Connection con = null;

    public static Connection getConnection() {
        String host = null;
        String user = null;
        String password = null;
        String dbName = null;
        String port = null;
        try {
            InputStream is = ConnectionManager.class.getResourceAsStream(PROP_FILE);
            Properties prop = new Properties();
            prop.load(is);
            host = prop.getProperty("host");
            user = prop.getProperty("userName");
            password = prop.getProperty("password");
            dbName = prop.getProperty("database");
            port = prop.getProperty("port");
            is.close();
        } catch (Exception ex) {
            log.debug("Error while fetching information from connection config file :"+ ex);
        }
        try {
            String url = "jdbc:postgresql://" + host + ":" + port + "/" + dbName;
            Class.forName("org.postgresql.Driver").newInstance();
            con = DriverManager.getConnection(url, user, password);
            log.info("connection establised");
        } catch (Exception ex) {
            log.error("Error while establishing connection :"+ex);
        }
        return con;
    }
}
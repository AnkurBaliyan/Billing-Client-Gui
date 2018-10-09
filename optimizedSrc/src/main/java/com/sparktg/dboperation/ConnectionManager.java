package com.sparktg.dboperation;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConnectionManager {
	private static Logger log = LoggerFactory.getLogger(ConnectionManager.class);
	private static final String PROP_FILE = "/config.properties";
	private static Connection con = null;

	public static Connection getConnection() {
		try {
			InputStream is = ConnectionManager.class.getResourceAsStream(PROP_FILE);
			Properties prop = new Properties();
			prop.load(is);
			String host = prop.getProperty("host");
			String user = prop.getProperty("userName");
			String password = prop.getProperty("password");
			String dbName = prop.getProperty("database");
			String port = prop.getProperty("port");
			is.close();
			String url = "jdbc:postgresql://" + host + ":" + port + "/" + dbName;
			Class.forName("org.postgresql.Driver").newInstance();
			con = DriverManager.getConnection(url, user, password);
			log.info("connection establised");
		} catch (Exception e) {
			log.error("failed to establish connection, Error:" + e.getMessage(), e);
		}
		return con;
	}

	public static void closeConnection() {
		try {
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			log.error("failed to close connection, Error:" + e.getMessage(), e);
		}
	}
}

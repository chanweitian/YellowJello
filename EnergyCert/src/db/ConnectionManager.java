package db;

import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;

/**
 * A class that manages connections to the database. It also
 * has a utility method that close connections, statements and
 * resultsets
 */

public class ConnectionManager {

    // Localhost Settings! 
	
	private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static String JDBC_URL = "jdbc:mysql://localhost:3306/gtl";
    private static String JDBC_USER = "root";
    private static String JDBC_PASSWORD = "";
    private static Properties props = new Properties();
    
	
    // Openshift Settings!!!
	/*
    private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static String JDBC_URL = "jdbc:mysql://127.10.30.130:3306/gtl";
    private static String JDBC_USER = "adminGjbnEWc";
    private static String JDBC_PASSWORD = "4Wbtlw3MmbuR";
    private static Properties props = new Properties();
    */
	
	// Digital Ocean Settings
    /*
	private static String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static String JDBC_URL = "jdbc:mysql://greentransformationlab.com:3306/gtl";
    private static String JDBC_USER = "root";
    private static String JDBC_PASSWORD = "root";
    private static Properties props = new Properties();
	*/
    
    static {
        try {
            Class.forName(JDBC_DRIVER);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Gets a connection to the database
     *
     * @return the connection
     * @throws SQLException if an error occurs when connecting
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL,JDBC_USER,JDBC_PASSWORD);
    }

    /**
     * close the given connection, statement and resultset
     *
     * @param conn the connection object to be closed
     * @param stmt the statement object to be closed
     * @param rs   the resultset object to be closed
     */
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        System.out.println(ConnectionManager.getConnection());
    }
}

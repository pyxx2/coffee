package com.coffee.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String NAME = "root";
    private static final String URL = "jdbc:mysql://localhost:3306/coffee?characterEncoding=gb2312";
    private static final String PASSWORD = "root";
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private Connection conn = null;

    public Connection getCon() {
        return conn;
    }

    public DBConnection() {
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, NAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }

    }
}

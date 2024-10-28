package com.coffee.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String NAME = "main";  // RDS 用户名
    private static final String URL = "jdbc:mysql://coffee3.csp7eqfx8y3e.us-east-1.rds.amazonaws.com:3306/coffee?serverTimezone=UTC";  // RDS 数据库 URL
    private static final String PASSWORD = "lab_password";  // RDS 密码
    private static final String DRIVER = "com.mysql.jdbc.Driver";  // 新版驱动
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

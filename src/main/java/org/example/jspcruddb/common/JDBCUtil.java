package org.example.jspcruddb.common;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCUtil {
    private static final Connection con = null;

    private static final String DB_URL = "jdbc:mysql://walab.handong.edu:3306/OSS24_22100135";
    private static final String DB_USER = "OSS24_22100135";
    private static final String DB_PASSWORD = "soh1eeTh";
    private static final String DB_DRIVER = "com.mysql.jdbc.Driver";

    public static Connection getConnection() {
        try {
            Class.forName(DB_DRIVER); // MySQL JDBC 드라이버 로드
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return con;
    }
}

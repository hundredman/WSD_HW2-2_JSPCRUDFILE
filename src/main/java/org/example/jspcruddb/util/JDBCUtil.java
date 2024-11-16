package org.example.jspcruddb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    private static Connection con = null;
    public static Connection getConnection() {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            if (con == null) {
                con = DriverManager.getConnection("jdbc:mariadb://walab.handong.edu:3306/OSS24_22100135?user=OSS24_22100135&password=soh1eeTh");
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return con;
    }

    public static void close(Connection con) {
        try {
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

//    public static void main(String[] args) {
//        Connection con = JDBCUtil.getConnection();
//        if (con != null) {
//            System.out.println("Database connection established");
//        }
//    }
}

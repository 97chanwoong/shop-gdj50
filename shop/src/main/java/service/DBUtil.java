package service;

import java.sql.*;

public class DBUtil {
   public Connection getConnection() throws Exception{
      String url = "jdbc:mariadb://localhost:3306/shop";
      String dbuser = "root";
      String dbpw = "1234";
      Connection conn = DriverManager.getConnection(url,dbuser,dbpw);
      return conn;
   }
}
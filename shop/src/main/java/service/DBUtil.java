package service;

import java.sql.*;

public class DBUtil {
   public Connection getConnection() throws Exception{
      String url = "jdbc:mariadb://3.38.124.179:3306/shop";
      String dbuser = "root";
      String dbpw = "1234";
      Connection conn = DriverManager.getConnection(url,dbuser,dbpw);
      return conn;
   }
}
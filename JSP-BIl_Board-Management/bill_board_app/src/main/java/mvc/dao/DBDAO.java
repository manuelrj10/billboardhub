package mvc.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBDAO {

	private static Connection dbCon;
	private static String dbDriver;
	private static String dbURL;
	private static String userName;
	private static String passWord;

	

	public static void dbInit() {
		try {
			dbDriver = "com.mysql.cj.jdbc.Driver";
			dbURL = "jdbc:mysql://localhost:3306/bill_board";
			userName = "root";
			passWord = "mysql";
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public static void connect() throws ClassNotFoundException,SQLException		{
		dbInit();
		try {
			Class.forName(dbDriver);
			Connection con=DriverManager.getConnection(dbURL,userName,passWord);
			setDbCon(con);
		}catch(ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
		}
	}
	
	public static void setDbCon(Connection con) {
		dbCon=con;
	}
	
		public static Connection getDbCon() {
			return dbCon;
		}
		
	public static void close() throws SQLException {
		dbCon.close();
	}
	
}

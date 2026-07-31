package mvc.dao;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
	//================start==============get database connection==========
			/**
			 * @author :manuel
			 * @Date :05:06:2026
			 * @version : 1.0
			 * @purpose :get  database connection
			 * @param :Nothing
			 * @throws : Exception in case of closing connection
			 * @return : void
			 * @see    : Nothing
			 */
	
	public static Connection getConnection() throws SQLException{
		Connection con=null;
		try {
			DBDAO.connect();
			con=DBDAO.getDbCon();
		}catch(ClassNotFoundException |SQLException ex) {
			ex.printStackTrace();
		}
		return con;
	}

}

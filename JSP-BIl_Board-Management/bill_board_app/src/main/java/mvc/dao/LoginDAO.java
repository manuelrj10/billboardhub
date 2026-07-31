package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mvc.beans.LoginBean;

public class LoginDAO {
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static LoginBean checkLogin(LoginBean login) throws SQLException {
		LoginBean returnlogin = new LoginBean();
		if (conn == null) {
			conn = DBConnection.getConnection();
		}
		try {
			String Queary = "select * from login where login_username=? and login_password=? ";
			pstmt=conn.prepareStatement(Queary);
			pstmt.setString(1, login.getUsername());
			pstmt.setString(2, login.getPassword());
			rs=pstmt.executeQuery();
			while(rs.next()) {
				returnlogin.setUsername(rs.getString("login_username"));
				returnlogin.setRole(rs.getString("login_role"));
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnlogin;

	}

}

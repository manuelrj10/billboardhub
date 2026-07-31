package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mvc.beans.BillboardSizeBean;


public class BillboardSizeDAO {
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static boolean insertSize(BillboardSizeBean billboardSize) throws SQLException {

		int rs = 0;
		if (conn == null) {
			conn = DBConnection.getConnection();
		}
		try {
			String Queary = "insert into billboard_size(billboard_size) values(?)";
			pstmt = conn.prepareStatement(Queary);
			pstmt.setString(1, billboardSize.getBillboard_size());
			rs = pstmt.executeUpdate();
			if (rs > 0) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}

	public static List<BillboardSizeBean> getAllBillboardSizes() throws SQLException {

		List<BillboardSizeBean> lst = new ArrayList<>();
		if (conn == null) {
			conn = DBConnection.getConnection();
		}
		try {

			String Query = "select * from billboard_size";
			pstmt = conn.prepareStatement(Query);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				BillboardSizeBean billboard = new BillboardSizeBean();
				billboard.setBillboardsize_id(rs.getInt("billboardsize_id"));
				billboard.setBillboard_size(rs.getString("billboard_size"));
				lst.add(billboard);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return lst;

	}

}

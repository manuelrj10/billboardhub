package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.beans.BillboardPurchaseBean;

public class BillboardPurchaseDAO {

    // Method to create a booking record
    public static boolean addPurchase(BillboardPurchaseBean purchase) {
        String query = "INSERT INTO billboard_purchase (customer_id, locationsize_id, start_date, duration, amount) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, purchase.getCustomerID());
            pstmt.setInt(2, purchase.getLocationSizeId());
            pstmt.setString(3, purchase.getStartDate());
            pstmt.setInt(4, purchase.getDuration());
            pstmt.setFloat(5, purchase.getAmouunt());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method using an explicit 4-Table INNER JOIN to display complete text reports
    public static List<BillboardPurchaseBean> getAllPurchases() {
        List<BillboardPurchaseBean> list = new ArrayList<>();
        String query = "SELECT bp.purchase_id, bp.customer_id, bp.locationsize_id, bp.start_date, bp.duration, bp.amount, " +
                       "c.company_name, l.Location_name, b.billboard_size " +
                       "FROM billboard_purchase bp " +
                       "INNER JOIN customer c ON bp.customer_id = c.customer_id " +
                       "INNER JOIN location_size ls ON bp.locationsize_id = ls.locationsize_id " +
                       "INNER JOIN location l ON ls.location_id = l.location_id " +
                       "INNER JOIN billboard_size b ON ls.billboardsize_id = b.billboardsize_id " +
                       "ORDER BY bp.purchase_id DESC";
                       
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                BillboardPurchaseBean bean = new BillboardPurchaseBean();
                bean.setPurchaseId(rs.getInt("purchase_id"));
                bean.setCustomerID(rs.getInt("customer_id"));
                bean.setLocationSizeId(rs.getInt("locationsize_id"));
                bean.setStartDate(rs.getString("start_date"));
                bean.setDuration(rs.getInt("duration"));
                bean.setAmouunt(rs.getFloat("amount"));
                bean.setCompanyName(rs.getString("company_name"));
                bean.setLocationName(rs.getString("Location_name"));
                bean.setBillBoardSizetext(rs.getString("billboard_size"));
                list.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
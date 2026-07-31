package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.beans.BillboardPurchaseBean;

public class PaymentDAO {

    // Automatically check or insert pending payment log status if it doesn't exist
    public static List<BillboardPurchaseBean> getAllPaymentsStatus() {
        List<BillboardPurchaseBean> list = new ArrayList<>();
        // Left Join ensures all purchases show up, displaying payment_status or defaulting to 'Pending'
        String query = "SELECT bp.purchase_id, bp.amount, c.company_name, l.Location_name, " +
                       "COALESCE(p.payment_status, 'Pending') AS pay_status " +
                       "FROM billboard_purchase bp " +
                       "INNER JOIN customer c ON bp.customer_id = c.customer_id " +
                       "INNER JOIN location_size ls ON bp.locationsize_id = ls.locationsize_id " +
                       "INNER JOIN location l ON ls.location_id = l.location_id " +
                       "LEFT JOIN payment p ON bp.purchase_id = p.purchase_id " +
                       "ORDER BY bp.purchase_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                BillboardPurchaseBean bean = new BillboardPurchaseBean();
                bean.setPurchaseId(rs.getInt("purchase_id"));
                bean.setAmouunt(rs.getFloat("amount"));
                bean.setCompanyName(rs.getString("company_name"));
                bean.setLocationName(rs.getString("Location_name"));
                bean.setBillBoardSizetext(rs.getString("pay_status")); // temporary pass storage
                list.add(bean);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public static boolean updatePayment(int purchaseId, String status) {
        String checkQuery = "SELECT COUNT(*) FROM payment WHERE purchase_id = ?";
        String insertQuery = "INSERT INTO payment (payment_status, purchase_id) VALUES (?, ?)";
        String updateQuery = "UPDATE payment SET payment_status = ? WHERE purchase_id = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            boolean exists = false;
            try (PreparedStatement checkPstmt = conn.prepareStatement(checkQuery)) {
                checkPstmt.setInt(1, purchaseId);
                try (ResultSet rs = checkPstmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) exists = true;
                }
            }
            
            String targetQuery = exists ? updateQuery : insertQuery;
            try (PreparedStatement pstmt = conn.prepareStatement(targetQuery)) {
                pstmt.setString(1, status);
                pstmt.setInt(2, purchaseId);
                return pstmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
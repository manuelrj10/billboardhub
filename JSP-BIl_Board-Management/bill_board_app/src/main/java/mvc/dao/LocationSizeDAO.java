package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.beans.LocationSizeBean;

public class LocationSizeDAO {

    // Method to insert a new mapping entry
    public static boolean addLocationSizeMapping(LocationSizeBean locSize) {
        String query = "INSERT INTO location_size (location_id, billboardsize_id, price, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, locSize.getLocation_id());
            pstmt.setInt(2, locSize.getBillboardsize_id());
            pstmt.setFloat(3, locSize.getPrice());
            pstmt.setString(4, locSize.getStatus());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<LocationSizeBean> getAllLocationSizeMappings() {
        List<LocationSizeBean> list = new ArrayList<>();
        String query = "SELECT ls.locationsize_id, ls.location_id, ls.billboardsize_id, ls.price, ls.status, " +
                       "l.Location_name, b.billboard_size " +
                       "FROM location_size ls " +
                       "INNER JOIN location l ON ls.location_id = l.location_id " +
                       "INNER JOIN billboard_size b ON ls.billboardsize_id = b.billboardsize_id";
                       
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                LocationSizeBean bean = new LocationSizeBean();
                bean.setLocationsize_id(rs.getInt("locationsize_id"));
                bean.setLocation_id(rs.getInt("location_id"));
                bean.setBillboardsize_id(rs.getInt("billboardsize_id"));
                bean.setPrice(rs.getFloat("price"));
                bean.setStatus(rs.getString("status"));
                bean.setLocationName(rs.getString("Location_name"));
                bean.setBillboardSizeText(rs.getString("billboard_size"));
                list.add(bean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
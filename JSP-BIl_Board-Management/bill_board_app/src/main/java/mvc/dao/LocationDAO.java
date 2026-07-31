package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import mvc.beans.LocationBean;


public class LocationDAO {
	
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static boolean insertLocation(LocationBean location) throws SQLException {
		
		int rs=0;
		if (conn == null) {
			conn = DBConnection.getConnection();
		}
		try {
			String Queary = "insert into location(Location_name,Location_address) values(?,?)";
			pstmt=conn.prepareStatement(Queary);
			pstmt.setString(1, location.getLocationName());
			pstmt.setString(2, location.getLocationAddress());
			rs=pstmt.executeUpdate();
			if(rs>0) {
				return true;
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}
	public static List<LocationBean> getAllLocations() throws SQLException {

		List<LocationBean> locations = new ArrayList<>();
		if (conn == null) {
			conn = DBConnection.getConnection();
		}
		try {

			String Query = "select * from location";
			pstmt = conn.prepareStatement(Query);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				LocationBean category = new LocationBean();
				category.setLocationID(rs.getInt("location_id"));
				category.setLocationName(rs.getString("location_name"));
				category.setLocationAddress(rs.getString("location_address"));
				locations.add(category);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return locations;
	}
	public static LocationBean getLocationById(int id) throws SQLException {
        LocationBean location = null;
        String query = "select * from location where location_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    location = new LocationBean();
                    location.setLocationID(rs.getInt("location_id"));
                    location.setLocationName(rs.getString("location_name"));
                    location.setLocationAddress(rs.getString("location_address"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return location;
    }

   
    public static boolean updateLocation(LocationBean location) throws SQLException {
        String query = "update location set Location_name = ?, Location_address = ? where location_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setString(1, location.getLocationName());
            pstmt.setString(2, location.getLocationAddress());
            pstmt.setInt(3, location.getLocationID());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean deleteLocation(int id) throws SQLException {
        String query = "delete from location where location_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

}

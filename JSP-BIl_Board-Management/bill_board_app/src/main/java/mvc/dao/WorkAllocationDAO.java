package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.beans.WorkAllocationBean;

public class WorkAllocationDAO {

    public static boolean allocateTask(WorkAllocationBean task) {
        String query = "INSERT INTO work_allocation (inspector_id, purchase_id, assigned_date, work_description, status) VALUES (?, ?, ?, ?, 'Assigned')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, task.getInspectorId());
            pstmt.setInt(2, task.getPurchaseId());
            pstmt.setString(3, task.getAssignedDate());
            pstmt.setString(4, task.getWorkDescription());
            
            int affected = pstmt.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<WorkAllocationBean> getAllAllocatedTasks() {
        List<WorkAllocationBean> list = new ArrayList<>();
        String query = "SELECT wa.work_id, wa.assigned_date, wa.work_description, wa.status, " +
                       "i.inspector_name, c.company_name, l.Location_name " +
                       "FROM work_allocation wa " +
                       "INNER JOIN inspector i ON wa.inspector_id = i.inspector_id " +
                       "INNER JOIN billboard_purchase bp ON wa.purchase_id = bp.purchase_id " +
                       "INNER JOIN customer c ON bp.customer_id = c.customer_id " +
                       "INNER JOIN location_size ls ON bp.locationsize_id = ls.locationsize_id " +
                       "INNER JOIN location l ON ls.location_id = l.location_id " +
                       "ORDER BY wa.work_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                WorkAllocationBean task = new WorkAllocationBean();
                task.setWorkId(rs.getInt("work_id"));
                task.setAssignedDate(rs.getString("assigned_date"));
                task.setWorkDescription(rs.getString("work_description"));
                task.setStatus(rs.getString("status"));
                task.setInspectorName(rs.getString("inspector_name"));
                task.setCompanyName(rs.getString("company_name"));
                task.setLocationName(rs.getString("Location_name"));
                list.add(task);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
 // Fetch only tasks allocated to a specific inspector based on their login_id
    public static List<WorkAllocationBean> getTasksForInspector(int loginId) {
        List<WorkAllocationBean> list = new ArrayList<>();
        String query = "SELECT wa.work_id, wa.assigned_date, wa.work_description, wa.status, " +
                       "c.company_name, l.Location_name " +
                       "FROM work_allocation wa " +
                       "INNER JOIN inspector i ON wa.inspector_id = i.inspector_id " +
                       "INNER JOIN billboard_purchase bp ON wa.purchase_id = bp.purchase_id " +
                       "INNER JOIN customer c ON bp.customer_id = c.customer_id " +
                       "INNER JOIN location_size ls ON bp.locationsize_id = ls.locationsize_id " +
                       "INNER JOIN location l ON ls.location_id = l.location_id " +
                       "WHERE i.login_id = ? " +
                       "ORDER BY wa.work_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, loginId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    WorkAllocationBean task = new WorkAllocationBean();
                    task.setWorkId(rs.getInt("work_id"));
                    task.setAssignedDate(rs.getString("assigned_date"));
                    task.setWorkDescription(rs.getString("work_description"));
                    task.setStatus(rs.getString("status"));
                    task.setCompanyName(rs.getString("company_name"));
                    task.setLocationName(rs.getString("Location_name"));
                    list.add(task);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // Method to update the operational status of an inspection task
    public static boolean updateTaskStatus(int workId, String status) {
        String query = "UPDATE work_allocation SET status = ? WHERE work_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, status);
            pstmt.setInt(2, workId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
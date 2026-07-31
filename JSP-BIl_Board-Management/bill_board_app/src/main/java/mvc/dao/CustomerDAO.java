package mvc.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import mvc.beans.CustomerBean;

public class CustomerDAO {

	public static boolean addCustomer(CustomerBean customer) {
		String query = "insert into customer(company_name,contact_person,phone)values(?,?,?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, customer.getCompanyName());
			pstmt.setString(2, customer.getContactPerson());
			pstmt.setString(3, customer.getPhone());

			int rows = pstmt.executeUpdate();
			if (rows > 0) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		return false;
	}

	public static List<CustomerBean> getAllCustomers() {
		List<CustomerBean> list = new ArrayList<>();
		String query = "select * from customer";
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				CustomerBean customer = new CustomerBean();
				customer.setCustomerId(rs.getInt("customer_id"));
				customer.setCompanyName(rs.getString("company_name"));
				customer.setContactPerson(rs.getString("contact_person"));
				customer.setPhone(rs.getString("phone"));
				list.add(customer);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
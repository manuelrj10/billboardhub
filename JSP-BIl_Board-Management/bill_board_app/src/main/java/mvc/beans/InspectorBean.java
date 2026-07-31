package mvc.beans;

public class InspectorBean {
	private int inspectorId;
	private int loginId;
	private String inspectorName;
	private String phone;

	// For registration utility mapping
	private String username;
	private String password;

	// Getters and Setters
	public int getInspectorId() {
		return inspectorId;
	}

	public void setInspectorId(int inspectorId) {
		this.inspectorId = inspectorId;
	}

	public int getLoginId() {
		return loginId;
	}

	public void setLoginId(int loginId) {
		this.loginId = loginId;
	}

	public String getInspectorName() {
		return inspectorName;
	}

	public void setInspectorName(String inspectorName) {
		this.inspectorName = inspectorName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
package mvc.beans;

public class WorkAllocationBean {
	private int workId;
	private int inspectorId;
	private int purchaseId;
	private String assignedDate;
	private String workDescription;
	private String status;

	// Extra presentation variables for the admin report table view
	private String inspectorName;
	private String companyName;
	private String locationName;

	// Getters and Setters
	public int getWorkId() {
		return workId;
	}

	public void setWorkId(int workId) {
		this.workId = workId;
	}

	public int getInspectorId() {
		return inspectorId;
	}

	public void setInspectorId(int inspectorId) {
		this.inspectorId = inspectorId;
	}

	public int getPurchaseId() {
		return purchaseId;
	}

	public void setPurchaseId(int purchaseId) {
		this.purchaseId = purchaseId;
	}

	public String getAssignedDate() {
		return assignedDate;
	}

	public void setAssignedDate(String assignedDate) {
		this.assignedDate = assignedDate;
	}

	public String getWorkDescription() {
		return workDescription;
	}

	public void setWorkDescription(String workDescription) {
		this.workDescription = workDescription;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInspectorName() {
		return inspectorName;
	}

	public void setInspectorName(String inspectorName) {
		this.inspectorName = inspectorName;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
}
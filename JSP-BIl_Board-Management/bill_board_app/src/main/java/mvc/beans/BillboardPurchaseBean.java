package mvc.beans;

public class BillboardPurchaseBean {
	private int purchaseId;
	private int customerID;
	private int locationSizeId;
	private String startDate;
	private int duration;
	private float amouunt;

	private String companyName;
	private String locationName;
	private String billBoardSizetext;

	public int getPurchaseId() {
		return purchaseId;
	}

	public void setPurchaseId(int purchaseId) {
		this.purchaseId = purchaseId;
	}

	public int getCustomerID() {
		return customerID;
	}

	public void setCustomerID(int customerID) {
		this.customerID = customerID;
	}

	public int getLocationSizeId() {
		return locationSizeId;
	}

	public void setLocationSizeId(int locationSizeId) {
		this.locationSizeId = locationSizeId;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public float getAmouunt() {
		return amouunt;
	}

	public void setAmouunt(float amouunt) {
		this.amouunt = amouunt;
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

	public String getBillBoardSizetext() {
		return billBoardSizetext;
	}

	public void setBillBoardSizetext(String billBoardSizetext) {
		this.billBoardSizetext = billBoardSizetext;
	}

}

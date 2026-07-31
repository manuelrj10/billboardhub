package mvc.beans;

public class LocationSizeBean {
	private int locationsize_id;
	private int location_id;
	private int billboardsize_id;
	private float price;
	private String status;
	private String locationName;
	private String billboardSizeText;

	public String getLocationName() {
		return locationName;
	}

	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}

	public String getBillboardSizeText() {
		return billboardSizeText;
	}

	public void setBillboardSizeText(String billboardSizeText) {
		this.billboardSizeText = billboardSizeText;
	}

	public int getLocationsize_id() {
		return locationsize_id;
	}

	public void setLocationsize_id(int locationsize_id) {
		this.locationsize_id = locationsize_id;
	}

	public int getLocation_id() {
		return location_id;
	}

	public void setLocation_id(int location_id) {
		this.location_id = location_id;
	}

	public int getBillboardsize_id() {
		return billboardsize_id;
	}

	public void setBillboardsize_id(int billboardsize_id) {
		this.billboardsize_id = billboardsize_id;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}

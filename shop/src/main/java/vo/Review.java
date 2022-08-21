package vo;

public class Review {
	private int ordersNo;
	private String reviewContents;
	private String updateDate;
	private String createDate;
	public Review() {
		super();
	}
	public Review(int ordersNo, String reviewContents, String updateDate, String createDate) {
		super();
		this.ordersNo = ordersNo;
		this.reviewContents = reviewContents;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	public int getOrdersNo() {
		return ordersNo;
	}
	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}
	public String getReviewContents() {
		return reviewContents;
	}
	public void setReviewContents(String reviewContents) {
		this.reviewContents = reviewContents;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "Review [ordersNo=" + ordersNo + ", reviewContents=" + reviewContents + ", updateDate=" + updateDate
				+ ", createDate=" + createDate + "]";
	}
	
	
}

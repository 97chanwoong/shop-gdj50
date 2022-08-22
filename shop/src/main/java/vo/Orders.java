package vo;

public class Orders {
	private int ordersNo;
	private int goodsNo;
	private String customerId;
	private int ordersQuantity;
	private int ordersPrice;
	private String ordersAddress;
	private String ordersDeAddress;
	private String ordersState;
	private String updateDate;
	private String createDate;
	public Orders() {
		super();
	}
	public Orders(int ordersNo, int goodsNo, String customerId, int ordersQuantity, int ordersPrice,
			String ordersAddress, String ordersDeAddress, String ordersState, String updateDate, String createDate) {
		super();
		this.ordersNo = ordersNo;
		this.goodsNo = goodsNo;
		this.customerId = customerId;
		this.ordersQuantity = ordersQuantity;
		this.ordersPrice = ordersPrice;
		this.ordersAddress = ordersAddress;
		this.ordersDeAddress = ordersDeAddress;
		this.ordersState = ordersState;
		this.updateDate = updateDate;
		this.createDate = createDate;
	}
	public int getOrdersNo() {
		return ordersNo;
	}
	public void setOrdersNo(int ordersNo) {
		this.ordersNo = ordersNo;
	}
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public int getOrdersQuantity() {
		return ordersQuantity;
	}
	public void setOrdersQuantity(int ordersQuantity) {
		this.ordersQuantity = ordersQuantity;
	}
	public int getOrdersPrice() {
		return ordersPrice;
	}
	public void setOrdersPrice(int ordersPrice) {
		this.ordersPrice = ordersPrice;
	}
	public String getOrdersAddress() {
		return ordersAddress;
	}
	public void setOrdersAddress(String ordersAddress) {
		this.ordersAddress = ordersAddress;
	}
	public String getOrdersDeAddress() {
		return ordersDeAddress;
	}
	public void setOrdersDeAddress(String ordersDeAddress) {
		this.ordersDeAddress = ordersDeAddress;
	}
	public String getOrdersState() {
		return ordersState;
	}
	public void setOrdersState(String ordersState) {
		this.ordersState = ordersState;
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
		return "Orders [ordersNo=" + ordersNo + ", goodsNo=" + goodsNo + ", customerId=" + customerId
				+ ", ordersQuantity=" + ordersQuantity + ", ordersPrice=" + ordersPrice + ", ordersAddress="
				+ ordersAddress + ", ordersDeAddress=" + ordersDeAddress + ", ordersState=" + ordersState
				+ ", updateDate=" + updateDate + ", createDate=" + createDate + "]";
	}
	
}

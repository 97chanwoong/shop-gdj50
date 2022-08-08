package vo;

public class GoodsImg {
	private int goodsNo;
	private String fileName;
	private String originFilename;
	private String contentType;
	private String createDate;
	public int getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(int goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriginFilename() {
		return originFilename;
	}
	public void setOriginFilename(String originFilename) {
		this.originFilename = originFilename;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "GoodsImg [goodsNo=" + goodsNo + ", fileName=" + fileName + ", originFilename=" + originFilename
				+ ", contentType=" + contentType + ", createDate=" + createDate + "]";
	}
	
}

package vo;

public class Counter {
	private String counterDate;
	private int counterNum;

	public Counter() {
		super();
	}

	public Counter(String counterDate, int counterNum) {
		super();
		this.counterDate = counterDate;
		this.counterNum = counterNum;
	}

	public String getCounterDate() {
		return counterDate;
	}

	public void setCounterDate(String counterDate) {
		this.counterDate = counterDate;
	}

	public int getCounterNum() {
		return counterNum;
	}

	public void setCounterNum(int counterNum) {
		this.counterNum = counterNum;
	}

	@Override
	public String toString() {
		return "Counter [counterDate=" + counterDate + ", counterNum=" + counterNum + "]";
	}

}

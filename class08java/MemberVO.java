package CHAPTER11.chapter11_0915;
//vo ==dto 현업에선 vo를 많이 쓴다.
public class MemberVO {
	private String memId;
	private String memName;
	private String memHp;
	private String memMail;

	public MemberVO(String memId, String memName, String memHp, String memMail) {
		this.memId = memId;
		this.memName = memName;
		this.memHp = memHp;
		this.memMail = memMail;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemHp() {
		return memHp;
	}

	public void setMemHp(String memHp) {
		this.memHp = memHp;
	}

	public String getMemMail() {
		return memMail;
	}

	public void setMemMail(String memMail) {
		this.memMail = memMail;
	}

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memName=" + memName + ", memHp=" + memHp + ", memMail=" + memMail + "]";
	}
}

package homeworks09;

public class BankAcoount {
	//잔액
	private int balance;
	//생성자(잔액 초기 세팅)
	public BankAcoount(int balance) {
		this.balance = balance;
	}
	//잔고
	public int getBalance() {
		return balance;
	}
	//입금 누적액
	public void deposit(int amount) {
		this.balance += amount;
	}
	/**
	 * 출금
	 * @param amount: 출금할 금액
	 * @return 출금 성공시 true 실패시 false
	 */
	//출금가능여부
	public boolean withdraw(int amount) {
		if (balance>=amount) {
			this.balance -=amount;
			return true;
		}else {
		return false;}
	}
	//계좌이체 가능여부
	//객체.밸런스로 접근:현재계좌 잔액
	public boolean transfer(int amount, BankAcoount otherAccount) {
		if (withdraw(amount)) {
//			상대방 계봐네 금액 입금
			otherAccount.deposit(amount);
			return true;
		}else {
			return false;
		}
	}


}
package homeworks_09M;

public class BankAccount {
	//잔액
	private int balance;
	//생성자(잔액 초기 세팅)
	public BankAccount(int balance) {
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
	//출금가능여부
	public boolean withdraw(int amount) {
		if (balance>=amount) {
			return true;
		}else {
		return false;}
	}
	//계좌이체 가능여부
	//객체.밸런스로 접근:현재계좌 잔액
	public boolean transfer(int amount, BankAccount otherAccount) {
		if (balance >= amount) {
			System.out.println("출금가능");
			return true;
		}else {
			System.out.println("잔액부족");
			return false;
		}
	}
	
	
}

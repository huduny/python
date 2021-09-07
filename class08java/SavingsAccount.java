package homeworks09_01;

public class SavingsAccount extends BankAcoount {
	
	private double interestRate;

	public SavingsAccount(int balance, double interestRate) {
		super(balance);
		this.interestRate = interestRate;
	}
	
	void updateBalance(int period) {
		this.balance += this.balance*interestRate*period;
	}
	
	

	

}

package homeworks09_09_02;

public class SavingsAccount extends BankAcoount {
	
	private double interestRate;

	public SavingsAccount(int balance, double interestRate) {
		super(balance);
		this.interestRate = interestRate;
	}
	
	void updateBalance(int period) {
		this.balance += this.balance*interestRate*period;
		
	}

	@Override
	String getAccountType() {
		// TODO Auto-generated method stub
		return String.format("저축예금"+"%d", this.balance);
	}
	
	

	

}

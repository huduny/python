package homeworks09_09_02;

public class CheckingAccount extends BankAcoount{
	private SavingsAccount protectedBy;

	public CheckingAccount(int balance) {
		super(balance);
	}

	public CheckingAccount(int balance, SavingsAccount protectedBy) {
		super(balance);
		this.protectedBy = protectedBy;
	}
	/**
	 * 수퍼클래스의 withdraw(int amount)를 재정의하고 만약 잔액보다 더 많은 값을 인출하려고 하면 초과되는
	 * 만큼의 돈을 참조하고 있는 SavingsAccount에서 인출
	 * @param amount: 이체할 금액
	 */
	
	@Override
	public boolean withdraw(int amount) {
		if (this.balance<amount) {
//			protectedBy.balance -= amount - this.balance;
			if (protectedBy.withdraw(amount-this.balance)) {
				this.balance = 0;
				return true;
			}
			return false;
		}
		return super.withdraw(amount);
	}

	@Override
	String getAccountType() {
		
	  return String.format("당좌예금"+"%d", this.balance);
	}
	
	
	
}

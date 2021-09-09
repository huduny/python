package homeworks09_09_02;

public class Customer {
	private String firstName;
	private String lastName;
	private BankAcoount[] accounts;
	private int numberOfAcoounts;
	
	//주어진 인자로 각 필드 초기화
	public Customer(String firstName, String lastName) {
		this.firstName = firstName;
		this.lastName = lastName;
		accounts = new BankAcoount[5];
	}
	//get,set메서드
	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}
	/**
	 * BankAcoount 배열에 인자로 전달된 계좌(account)를 추가하고,
	 * numberOfAccounts 값을 1 증가시킨다.
	 * @param account
	 */
	void addAcoount(BankAcoount account) {
		accounts[numberOfAcoounts++] = account;
	}
	/**
	 * accounts 배열의 index에 해당하는 BankAccount 객체 반환
	 * @param index
	 * @return
	 */
	public BankAcoount getAccount(int index) {
		return accounts[index];
	}
	
	public int getNumberOfAcoounts() {
		return numberOfAcoounts;
	}
	public String toString() {
//		return "고객의 이름: "+firstName+lastName+"잔액: "+account.getBalance();
		return String.format("%s"+ " %s ", firstName, lastName);
	}
//	객체 타입은 안되고 리턴타입이 인트형인걸로 해서 %d로 해준다.

} 
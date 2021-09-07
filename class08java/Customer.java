package homeworks09;

public class Customer {
	private String firstName;
	private String lastName;
	private BankAcoount account;

	//주어진 인자로 각 필드 초기화
	public Customer(String firstName, String lastName) {
		this.firstName = firstName;
		this.lastName = lastName;
	}
	//get,set메서드
	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public BankAcoount getAccount() {
		return account;
	}

	public void setAccount(BankAcoount account) {
		this.account = account;
	}

	public String toString() {
//		return "고객의 이름: "+firstName+lastName+"잔액: "+account.getBalance();
		return String.format("이름: %s %s, 잔고: %,d원", firstName, lastName, account.getBalance());
	}
//	객체 타입은 안되고 리턴타입이 인트형인걸로 해서 %d로 해준다.

} 
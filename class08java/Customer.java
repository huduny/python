package homeworks_09M;

public class Customer{
	private String firstName;
	private String lastName;
	private BankAccount account;
	
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
	
	public BankAccount getAccount() {
		return account;
	}

	public void setAccount(BankAccount account) {
		this.account = account;
	}
	
	public String toString() {
		return "고객의 이름: "+firstName+lastName+"잔액: "+account.getBalance();
	}
	
}
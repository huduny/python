package homeworks_09M;

public class Bank {
	
	//은행고객목록
	Customer[] customers;
	//은행 고객수
	int numberOfCustomers;
	
	public Bank(){
		this.customers = new Customer[10];
	}
	//고객 등록
	public void addCustomer(Customer customers) {
	//고객을 배열에 할당
//		customer[0] <- customer객체
		this.customers[numberOfCustomers]=customers;
//		객체 배열의 index값을 1증가
		numberOfCustomers++;
	}
	public Customer[] getCustomers() {
		return customers;
	}
	public int getNumberOfCustomers() {
		return numberOfCustomers;
	}
	
//	인덱스 번째 고객을 반환
	public Customer getCustomer(int index) {
		return this.customers[index];
	}

}
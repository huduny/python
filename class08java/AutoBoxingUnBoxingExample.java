package CHAPTER11.chapter11_02;

public class AutoBoxingUnBoxingExample {

	public static void main(String[] args) {
		Integer obj = 100;
		System.out.println("value: "+obj.intValue());
		
		int value = obj;
		System.out.println("value: "+ value);
		
		int result = obj +100;
		System.out.println("result: "+ result);00

	}

}

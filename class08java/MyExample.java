package CHAPTER8.chapter8_1;

public class MyExample {
	public static void main(String[] args) {
		System.out.println("10--------------------------");
		MyClass myClass = new MyClass();
		myClass.rc.turnOn();
		myClass.rc.setVolume(10);
		
		System.out.println("2---------------------------");
//		MyClass myClass2 = new MyClass(new Audio()); //선언되는 것은 같거나 하위 타입이 올 수 있따.
		
		System.out.println("3---------------------------");
		MyClass myClass2 = new MyClass();
		myClass2.methodA();
		myClass2.methodB(new Audio());
	}
}

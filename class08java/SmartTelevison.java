package CHAPTER8.chapter8_1;

public class SmartTelevison extends Television implements RemoteControl, Serchable {
//	클래스는 다중상속이 불가능하지만 인터페이스는 여러개를 구현해 낼 수 있다.
//	extends는 상속 implements는 구현
	private int volume;
	@Override
	public void search(String message) {
		System.out.println(message+"를 검색합니다.");
		
	}
}

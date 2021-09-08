package CHAPTER9.chapter9_2;

public class PersonExample {
	public static void main(String[] args) {
//		Person person = new Person();
//		person.wake();
		
		new Person() {
			void wake() {
				System.out.println("8시에 일어 납니다.");
			}
		}.wake();
	}
//	클래스를 재정의 할 수 있다.
//	변수에 할당하는 것이 없는 것이 익명개체이다. 바로바로 사용할 수 있다. '.'의 앞이 주소값이다.
}

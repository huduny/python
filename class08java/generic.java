package CHAPTER11.chaper110916;

public class generic<E> {
	private E value;
//	object로 선언하면 어떤 타입인지 알 수 없으니 명확히 하기 위해서 class 이름 옆에
//	<>안에 타입을 쓰면 클래스 안에 타입을 쓸수 있다.
//	선언할때도 box<integer> box1 = new box<integer>(10); 이라고 하면 integer타입
//	선언할때도 box<String> box1 = new box<>(10); 이라고 하면 String타입
//	제네릭 메소드
	public <E> void running(E e) {
		e.toString();
	}
}

package CHAPTER11.chaper11_01;

public class ReflectionExample {
	public static void main(String[] args) {
		Key key = new Key(10);
		
		Key.class.getDeclaredFields("number");
//		reflection은 private으로 선언한 필드에 접근해서 값을 변경할 수 있다 (위험하다)
//		해킹하는 사람들이 많이 쓴다.
	}
}

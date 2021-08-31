package CHAPTER6;

public class Singleton21083102 {
	private static Singleton21083102 instance = new Singleton21083102(); // field value
//	instance가 만들어질러면 Singleton21083102객체를 생성해야 된다
//	private이여서 생성이 안된다.
//	외부에서 접근을 할려면 생성하지 않고도 method나 field에 접근할 수 있는데
//	static 붙어있는 것은 메소드영역에 올려 있어서 사용 가능
//	private로 못써서 static을 붙여준다
	
//	필드는 데이터고 변수는 매우 중요하다, 따라서 변수를 사용하게 하는 것은 위험하다
//	메소드라는 접근할 수 있는 방법을 따로 적용해준다, 따라서 private으로 막아주고
	private	Singleton21083102() {
	
	}
	public static Singleton21083102 getInstance() {
		return instance;
//	instance라는 필드값을 반환해준다.
//	privat들이어서 못사용하기 때문에 static을 붙여준다.
//	어디서든 사용할수 있게 public을 붙여준다
//	Singleton과 getInstance는 짝궁같이 정형화 되어 있
		final int a = 10;
		a= 30;
		stat 
	}
	
}// class end

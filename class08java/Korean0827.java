package CHAPTER6;

public class Korean0827 {
	
	String name;
	String phoneNum;
	String emailAdd;
	
//	1.은 초기화를 해주고
	public Korean0827() {
		
	}
//	2.외부 값으로 받기 위해서
	/*
	 * Korean0827 생성자
	 * @param n : 이름
	 * @param h : 번호
	 * @param e : 이메일
	 */
	public Korean0827(String name) {
		this.name = name;
		this(name, null, null);
	}
	public Korean0827(String name, String phoneNum, String emailAdd) {
		this.name = name;
		this.phoneNum = phoneNum;
		this.emailAdd = emailAdd;
//		메모리상에 만들어져 있는 객체 자신을 this로 지칭한다
//		필드에 있는 변수와 지역의 변수를 구분하기 위해서 this라는 명령어를 쓴다.
//		생성자를 여러개 만드는 것을 overloading이라고 한다.
//		this(); this는 자기 자신을 가르킨다. this()=Korean0827() 이어서 Korean0827()호출
//		this(); 하나의 생성자에서 중복된 호출을 관리하기 위해서 사용한다
//		첫번째 호출 
	}
}

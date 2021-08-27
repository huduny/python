package CHAPTER6;

public class Korean0827Example {

	public static void main(String[] args) {
		Korean0827 korean1 = new Korean0827("홍길동", "010-1234-5678", "hong@naver.com");
//		생성함과 동시에 여기 안에 있는 값들로 초기화 해준다.
		Korean0827 korean2 = new Korean0827("이순신", "010-1234-4321", "lee@daum.net");
		Korean0827 korean3 = new Korean0827("박자바", "010-4321-8473", "park@nate.com");
		Korean0827 korean4 = new Korean0827("감자바", "010-5432-2844", "kam@gmail.com");
		Korean0827 korean5 = new Korean0827("최하얀", "010-3987-0981", "choi@kakao.com");
		Korean0827 korean6 = new Korean0827("oh");
//		사람이 5명이여서 5개의 객체를 생성해야된다
		
		korean1.name = "홍길동";
		korean1.emailAdd = "010-1234-5678";
		korean1.phoneNum = "hong@naver.com";
		
		korean2.name = "이순신";
		korean2.emailAdd = "010-1234-4321";
		korean2.phoneNum = "lee@daum.net";
		
		korean3.name = "박자바";
		korean3.emailAdd = "010-4321-8473";
		korean3.phoneNum = "park@nate.com";
		
		korean4.name = "감자바";
		korean4.emailAdd = "010-5432-2844";
		korean4.phoneNum = "kam@gmail.com";
		
		korean5.name = "최하얀";
		korean5.emailAdd = "010-3987-0981";
		korean5.phoneNum = "choi@kakao.com";
//		생성자를 사용하면 초기화 뿐만 아니라 반복적인 코딩을 효율적으로 만들어 준다.
//		아예 필드에 들어갈 값들을 미리 넣어주면 그 값들로 초기화를 시켜준다.
		
	}

}

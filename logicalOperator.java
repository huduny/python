package CHAPTER3;

public class logicalOperator {

	public static void main(String[] args) {
//		논리 연산자(boolean타입만 사용가능)
//	    현재 시각이고 12시이전이고 날씨가 비가오면(2개의 조건)
//		이고 또는 &(and) |(or) ^(배타적논리합-현업에서는 아예 안쓴다) !(부정)
//		
		int charCode = 'A'; //65
		
//		if (조건식){}
		if (charCode >= 65 & charCode <=90) {
			System.out.println("대문자입니다.");
		}
		if (charCode >= 97 && charCode <= 122) {
			System.out.println("소문자입니다.");
		}
		if (charCode >= 65 | charCode <=90) {
			System.out.println("대문자입니다.");
		}
		if (charCode >= 97 || charCode <= 122) {
			System.out.println("소문자입니다.");
		}
//		&나| 하나짜리는 연산을 비트연산으로 한다 0과1로 판단 1이면 true
//		비트 연산자는 개발에 사용되지 않는다 앞에가 참이면 뒤에를 실행시켜본다 2가지를 실행해보고 판단
//		&&는 앞에가 거짓이면 결과가 거짓이므로 뒤에를 연산하지 않는다.
		
		
	}
}
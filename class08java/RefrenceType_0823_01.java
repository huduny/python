package CHAPTER5;

import java.util.Random;
import java.util.Scanner;

public class RefrenceType_0823_01 {

	public static void main(String[] args) {
		// TDD test driven development
//		&&나 ||을 잘 활용해야 된다.
//		조건 if switch
//		반복 for while
//		기본형 int double
//		참조형 scanner random String
//		기본형 참조형은 대문자 소문자의 차이가 있고, 색이 달랐다
//		기본형을 제외한 나머지는 다 참조 타입이다. 배열,열거,클래스,인터페이스
//		기본타입은 그 값이 바로 저장 되는데 참조타입은 그 값이 저장된 주소값을 가지고 있어서
//		주소를 참조해서 값을 가져온다.
		
//		Scanner scn = new Scanner(System.in);
//		int num = scn.nextInt();
//		System.out.println(num);
//		System.out.println(scn);
//		
		int a = 100;
		System.out.println(a);
		Random ran = new Random();
		System.out.println(ran);
//		oid => object id 인트는 그 값이 저장되고 참조형은 주소같은 oid를 가지고 있다.
		
//		클래스 main메소드 선언된 변수는 스택에서 관리 a라는 변수도 스택이라는 공간에 만들어진다.
//		참조타입을 사용할려면 메모리 공간이 필요한대 그때 만들어지는 공간이 힙이다.
//		메소드는 프로그램에 필요한 모든 자원들을 관리해주는 공간 예를 들어 임폴트할때 정보를 참고해야 되는데 그런 정보들을 담아주는 공간
//		자료구조 queue, stack, deque
//		
		Random ran1 = new Random();
		Random ran2 = new Random();
		Random ran3 = new Random();
//		랜덤이라는 객체를 세번 연속 만들면 힙이라는 공간에 랜덤1이 만들어지고 랜덤2,3도 만들어진다.
//		똑같은 random이라고 해도 같은 random이라는 객체이지만 주소값이 달라서 다르다.
		System.out.println(ran1 == ran2);
//		기본형은 항상 값을 직접 가지고 있지만 참조형은 주소값으로 비교한다.
		Random ran5 = null;
//		null을 쓰면 아무것도 참조하는 값이 없다.
		System.out.println(ran5);
//		ran5.nextInt(); // null은 주소가 없어서 호출을 못한다
		
//		String s = new String("gdfd")
//		이것을 a = "ads"로 기본형처럼 쓸 수 있게 해주었다. 원래는 위가 원칙이다.
//		문자열 관리 풀(pool)
		String s1 = "신용권";
		String s2 = "신용권";
//		문자가 똑같으면 똑같은 문자를 관리하는 스트링풀에 넣어지고 같은 주소를 가지게 된다.
		String s3 = new String("신용권");
		String s4 = new String("신용권");
//		주소가 다르다
		boolean result1 = s1 == s2;
		boolean result2 = s3 == s4;
		System.out.println(result1);
		System.out.println(result2);
//		effective java
		
		
		
		
	}

}

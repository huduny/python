package CHAPTER6;

import java.util.Scanner;

public class methodexample21083001 {

	public static void main(String[] args) {
//		동작을 실행
//		사용할 객체를 생성
		Scanner scn = new Scanner(System.in);
		method21083001 calculator = new method21083001();
//		calculator라는 변수 타입은 method21이라는 타입이다.
		calculator.powerOn();
		
		System.out.print("숫자를 입력하세요1> ");
		int a =scn.nextInt();
		System.out.print("숫자를 입력하세요2> ");
		int b =scn.nextInt();
		int result1 = calculator.plus(a, b);
		System.out.println(result1);
		
		System.out.println("값 입력: ");
		String first = scn.next();
		String second = scn.next();
		System.out.println(Integer.parseInt(first)+Integer.parseInt(second));
		int result2 = calculator.plus(Integer.parseInt((first)),Integer.parseInt((second)));
		System.out.println(result2);
//		next는 엔터 전까지 공백으로 값을 입력 받는다.
		scn.close();
		
	}

}

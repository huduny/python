package Chapter02;

import java.util.Scanner;

public class scannerexample {

	public static void main(String[] args) {
		// 사용자로부터 콘솔에서 데이터를 입력받을 때
		// scanner라는 클래스를 사용한다.
		// 클래스를 사용할 때는 반드시 neww 명령어로 생성한다.
		Scanner scanner = new Scanner(System.in);
		String s1 = scanner.nextLine();
		//문자열을 공백이나 엔터를 입력받을 때까지 입력받는다.
		//엔터를 제외하고 엔터 앞까지만 가져온다.
		String s2 = scanner.nextLine();
		//문자열을 엔터를 입력할 때까지의 문자열을 가져온다.
		//엔터까지 가져온다
		System.out.println(s1);
		System.out.println(s2);
		//데이터 타입이 문자일수도 숫자일수도 있다.
		//숫자를 입력하면 숫자가 나오지만 문자인 타입이다.
		int i1 = scanner.nextInt();
		int i2 = scanner.nextInt();
		System.out.println(i1);
		System.out.println(i2);
		
		

	}

}

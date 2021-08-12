package Chapter02;

import java.util.Scanner;

public class Confirm21 {

	public static void main(String[] args) {
		/*
		 *  다음과 같이 출력되도록 코드를 작성하시오.
		 *  이름, 나이, 전화번호를 입력받아서 출력
		 *  이름:감자바
		 *  나이:25
		 *  전화:010-1234-5678
		 */

	Scanner scanner = new Scanner(System.in);
	System.out.println("이름을 입력하세요");
	String name = scanner.nextLine();
	
	System.out.println("나이를 입력하세요");
	int age = scanner.nextInt();

	
	System.out.println("전화번호를 입력하세요");
	String number = scanner.next();

	
	System.out.println("전화번호를 입력하세요", "나이를 입력하세요");
	String number = scanner.next();
	}

}

package Chapter02;

import java.util.Scanner;

import javax.print.attribute.standard.PrinterMessageFromOperator;

public class Confirm21 {

	public static void main(String[] args) {
		/*
		 *  다음과 같이 출력되도록 코드를 작성하시오.
		 *  이름, 나이, 전화번호를 입력받아서 출력
		 *  이름:감자바
		 *  나이:25
		 *  전화:010-1234-5678
		 */
	//입력부분
	Scanner scanner = new Scanner(System.in);
	System.out.println("이름을 입력하세요");
	String name = scanner.nextLine();
	
	System.out.println("나이를 입력하세요");
	int age = scanner.nextInt();
	//int sum = age * 100;

	
	System.out.println("전화번호를 입력하세요");
	String number = scanner.next();
	//처리부분
	/*
	 * 로직, 연산자 
	 */
	
	//출력부분
	System.out.println("이름: " + name);
	//ln new line, line break
	System.out.println("나이: " + age);
	System.out.println("전화: " + number);
	System.out.println("이름: "+ name + ", 나이:"+ age + ", 전화" + number);
	//요즘방식
	System.out.println("이름: "+ name + ", 나이:"+ age + ", 전화" + number);
	//printf의 f는 format의 약자
	System.out.printf("이름: %s, 나이: %s, 전화: %s", name, age, number);
	//%뒤에 들어가는 형식 데이터 종류 string(s) 정수형(d)decimal 소수점(f)float
	System.out.printf("%,d", 154367);
	//%,d하면 자동 컴마가 찍힌다
	
	
	scanner.close();
	//메모리 누수를 방지해준다.
	
	}

}

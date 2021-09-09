package CHAPTER10.chapter10_1;

import java.util.Scanner;

public class ThrowExample {
public static void main(String[] args) throws Exception {
//	개발자가 직접 에러를 만들고 싶을때
//	new Exception();
	
//	개발자가 직접 에러를 발생시키고 싶을 때
//	throw new RuntimeException();
	
//	throws: 메서드를 호출한 놈에게 던져주는것, 메소드에게
//	throw: 뒤에 있는 에러를 직접 만드(발생)는 것이다. 개발자가 직접
//	두 수를 입력 받아서 첫번째 숫자가 두번째보다 크면 크다.
//	첫번째 숫자가 두번쨰 숫자보다 작으면 작다.
//	같으면 같다를 출력하는 프로그램을 작성하시오.
	Scanner scanner = new Scanner(System.in);
	System.out.println("첫번쨰 숫자 입력");
	int firstNum = scanner.nextInt();
	System.out.println("두번쨰 숫자 입력");
	int secondNum = scanner.nextInt();
	
	String result = "";
	try {
		if (firstNum>secondNum) {
			throw new BiggerThanException("크다");
		}else if (firstNum<secondNum) {
			throw new SmallerThanException("작다");
		}else {
			throw new EqualsException("같다");
		}
	} catch (Exception e) {
		System.out.println(e.getMessage());
		}

	
	
}
}

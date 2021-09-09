package homeworks09_09_01;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Exercise11 {
	public static void main(String[] args) {
		Scanner scn =new Scanner(System.in);
		int firstNumber = 0;
		int secondNumber = 0;
		int result = 0;
		boolean a = true;
		
		while(a) {
		try {	
			System.out.print("어떤 수로 나누겠습니까? ");
			firstNumber = scn.nextInt();

		} catch (InputMismatchException e) {
			System.out.println("잘못된 입력입니다. 다시 입력해주세요");
		}
		
		try {System.out.print("어떤 수로 나누겠습니까? ");
			secondNumber = scn.nextInt();
		} catch (InputMismatchException e) {
			System.out.println("0으로 나눌 수 없습니다. 다시 입력해주세요");
		} 	
		break;
		
		try {result = firstNumber/secondNumber;	
		} catch (ArithmeticException e) {
			System.out.println("0으로 나눌 수 없습니다. 다시 입력해주세요");
		}
		
		}	
		//a = false;
		//System.out.println(firstNumber+","+secondNumber+"결과"+result);
				

		
		
	}//main end
	
	
}

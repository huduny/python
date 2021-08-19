package homeworks;

import java.util.Scanner;

public class operatorhk01 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
// 		예제1 큰 수를 작은 수로 나눈 몫과 나머지를 출력하는 프로그램
//		((a + b) + |a - b|) / 2는 큰 수, ((a + b) - |a - b|) / 2는 작은 수
		Scanner scn = new Scanner(System.in);
		
//		variable
		
//		input
		System.out.print("첫 번째 숫자를 입력하세요: ");
		int first = scn.nextInt();
		System.out.print("두 번째 숫자를 입력하세요: ");
		int second = scn.nextInt();
		
//		process 2
		int a = ((first+second)+Math.abs(first-second))/2;
		int b = ((first+second)-Math.abs(first-second))/2;
		
//		output
		System.out.println("큰수를 작은 수로 나눈 몫은: " + (a/b) + "이고," + "나머지는 " + (a%b) + "이다.");
		
		scn.close();
		
		
		
		
		
		
		
		
	}

}

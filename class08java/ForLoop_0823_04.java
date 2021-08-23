package homeworks;

import java.util.Scanner;

public class ForLoop_0823_04 {

	public static void main(String[] args) {
//		// 두 사람이 하는 가위 바위 보 게임을 만들어 보자. 두 사람이 입력한 문자열을 비교하여 누가 이겼는지 출력하는 프로그램이다.
//		문자열을 읽기 위해서는 Scanner 클래스의 next() 메소드를 이용하면 된다. 또 자바에서 문자열 비교는 주의를 기울여야 한다. 
//		String 타입 변수와 문자열 비교는 == 이 아닌 equals() 메소드로 비교하여야 한다.
		Scanner scn = new Scanner(System.in);
		System.out.println("가위바위보 게임");
		
		//입력
		System.out.print("영희: ");
		String People1 = scn.next();
		System.out.print("철수: ");
		String People2 = scn.next();
		
		//처리
		if (People1.equals("가위")){
			if (People2.equals("가위")) {
				System.out.println("무승부 입니다.");
			}	
			if (People2.equals("보")) {
				System.out.println("영희 승리입니다.");
			}
			if (People2.equals("바위")) {
				System.out.println("철수 승리입니다.");
			}}
			
			else if (People1.equals("바위")){
			if (People2.equals("가위")) {
					System.out.println("영희 승리입니다.");
			}	
			if (People2.equals("보")) {
					System.out.println("철수 승리입니다.");
			}
			if (People2.equals("바위")) {
					System.out.println("무승부입니다.");
			}}
			
			else if (People1.equals("보")){
			if (People2.equals("가위")) {
					System.out.println("철수 승리입니다.");
			}	
			if (People2.equals("보")) {
					System.out.println("무승부 입니다.");
			}
			if (People2.equals("바위")) {
					System.out.println("영희 승리입니다.");
			}}
		
		//출력

		
	}

}

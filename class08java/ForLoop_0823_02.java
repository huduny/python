package homeworks;

import java.util.Scanner;

public class ForLoop_0823_02 {

	public static void main(String[] args) {
		// 사용자로부터 특정 월을 입력받은 후, 입력 받은 월의 계절이 어떤 계절인지 알아내는 프로그램을 만들어 보자. 
//		3월~5월은 봄, 6월~8월은 여름, 9월~11월은 가을, 12월~2월은 겨울을 출력한다.
//		실행 결과는 3번 반복되어 있지만 1번만 나오도록 작성하시면 됩니다.
//		변수
		Scanner scn = new Scanner(System.in);
		String Spring = "봄";
		String Summer = "여름";
		String Fall = "가을";
		String Winter = "겨울";
//		입력
		System.out.print("월을 입력하세요: ");
		int MonthIn = scn.nextInt();
//		처리
		if (MonthIn>=3 && MonthIn <=5) {
			System.out.println( MonthIn + "월은 " + Spring + "입니다.");
			
		}
		if (MonthIn>=6 && MonthIn <=8) {
			System.out.println( MonthIn + "월은 " + Summer + "입니다.");
			
		}
		if (MonthIn>=9 && MonthIn <=11) {
			System.out.println( MonthIn + "월은 " + Fall + "입니다.");
		}
		if (MonthIn>=12 && MonthIn <=2) {
			System.out.println( MonthIn + "월은 " + Winter + "입니다.");
		}
		
//		출력
		
		
	}

}

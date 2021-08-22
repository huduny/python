package homeworks;

import java.util.Scanner;

public class operatorhk03 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Scanner scn = new Scanner(System.in);
		
//		입력부분
		System.out.print("윤년인지를 확인할 연도를 입력하세요: ");
		int year = scn.nextInt();
				
//		처리부분
		String result = (((year%4 == 0) && (year%100 != 0)) || year%400 ==0)? "년은 윤년입니다." : "년은 윤년아닙니다.";
		
//		출력부분
		System.out.println(year + result);
		
		scn.close();
	
	
	
	
	
	}

}

package JAVA_YOUTUBE;

import java.util.Scanner;

public class for_20210816_03 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// if는 한번만 검사 while은 조건이 맞는지 다시한번 계속 검사
		
		int kor1, kor2, kor3;
		int total;
		float avg;
		Scanner scan = new java.util.Scanner(System.in);
		kor1 = 0;
		kor2 = 0;
		kor3 = 0;
		
		while(true){
//		성적 입력부분
		System.out.println("┌───────────────────────────────┐");
		System.out.print("└──────────\\성적입력\\─────────────┘\n");
		
		do {
			System.out.print("국어1: ");
			kor1 = scan.nextInt();
			
			if(kor1 < 0 || 100 < kor1)
				System.out.println("성적범위(0~100)를 벗어났습니다.");
		}while(kor1 < 0 || 100 < kor1); 
		
//		코드가 어떤 순서로 진행되고 예측해야 된다, 흐름을 제어할 수 있어야 된다
		do {
			System.out.print("국어2: ");
			kor2 = scan.nextInt();
			
			if(kor2 < 0 || 100 < kor2)
				System.out.println("성적범위(0~100)를 벗어났습니다.");
		}while(kor2 < 0 || 100 < kor2); 
		
		do {
			System.out.print("국어3: ");
			kor3 = scan.nextInt();
			
			if(kor3 < 0 || 100 < kor3)
				System.out.println("성적범위(0~100)를 벗어났습니다.");
		}while(kor3 < 0 || 100 < kor3); 
		
//	  	성적 출력 부분
		total = kor1 + kor2 + kor3;
		avg = total / 3.0f;
		
		System.out.println("┌───────────────────────────────┐");
		System.out.print("└──────────\\성적출력\\─────────────┘\n");
		
//		int i =0;
//		while( i < 3) {
//			System.out.printf("\t국어1 : %3d\n", kor1);
//			i++;
//		} for문을 이용하면 특정수 만큼 반복할 수 있다.
		
		for(int i =0; i<3; i++){
			System.out.printf("\t국어%d : %3d\n", 3-i, kor1);
		}
//		for안은 건들지 말고 그 안에서 해결해야 된다
//		1부터 시작하고 싶으면 for(int n=1; n<=3; n++)로 사용
//		for(int i =2; 0<=i && i<3; i--){
//			System.out.printf("\t국어%d : %3d\n", i+1, kor1);
//		}
//		for( ; i<3 ; ){} 앞 뒤가 빠져서 다른 곳에 존재 할 수 도 있다.
//		for( ; true ; ){} while문에 트루와 같다
//		for( ; ; ){} 무한루프가 돈다 이럴때는 while루프를 쓰자
//		for( int x=0, int y=0 ; x<0 ; x++, y=x ){} 조건 두개를 사용가능
		
		System.out.printf("\t총점 : %3d\n", total);
		System.out.printf("\t평균 : %6.3f\n", avg);

	}

 }

	private static Object desc(int i) {
		// TODO Auto-generated method stub
		return null;
	}
}
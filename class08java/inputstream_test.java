package JAVA_YOUTUBE;

import java.util.Scanner;

public class inputstream_test {
	
	public static void main(String[] args) {
		//inputstream과 객체 생성
		//next와nextline
		//nextint, nextfloat, nextdouble
		//이게 바로 scanner이다
		
//	 	성적 도구
		int kor1, kor2, kor3;
		int total;
		float avg;
		
		Scanner scan = new java.util.Scanner(System.in);
		//crtl+shift+o하면 임폴트 자동으로
	
		
		kor1 =0;
		kor2 =0;
		kor3 =0;
		//기본값으로 가지고 있어야 된다
		
//		성적 입력부분
		System.out.println("┌───────────────────────────────┐");
		System.out.print("└──────────\\성적입력\\─────────────┘\n");
		System.out.print("국어1: ");
		kor1 = scan.nextInt();
		System.out.print("국어2: ");
		kor2 = scan.nextInt();
		System.out.print("국어3: ");
		kor3 = scan.nextInt();
		
//	  	성적 출력 부분
		total = kor1 + kor2 + kor3;
		avg = total / 3.0f;
		
		System.out.println("┌───────────────────────────────┐");
		System.out.print("└──────────\\성적출력\\─────────────┘\n");
		
		System.out.printf("\t국어1 : %3d\n", kor1);
		System.out.printf("\t국어2 : %3d\n", kor2);
		System.out.printf("\t국어3 : %3d\n", kor3);
		System.out.printf("\t총점 : %3d\n", total);
		System.out.printf("\t평균 : %6.3f\n", avg);
		
		
		
		
		
		
	}

}

package JAVA_YOUTUBE;

import java.util.Scanner;

public class operator2 {

	public static void main(String[] args) {
		// ==, !=,>=,<=,&&,||
		//(-2<x)&&(x<=2)
		//비트 단위로 연산
		//~비트 부정 연산 0011이 1100이 된다
		//3<<2 3이라는 비트를 2칸만큼 왼쪽으로 민다 0011이 1100이된다
		//3>>2 0011이 0000이된다(쉬프트 연산자)
		//11>>2 1011은 1110(앞이 1이면 1로 채워진다)
		//+=덧셈 후에 대입 /=나눗셈 후에 대입 %=나머지 연산 후에 대입
		//?:삼항 연산자 비트 교집합 연산자
		
		int kor1, kor2, kor3;
		int total;
		float avg;
		Scanner scan = new java.util.Scanner(System.in);
		
//		성적 입력부분
		System.out.println("┌───────────────────────────────┐");
		System.out.print("└──────────\\성적입력\\─────────────┘\n");
		System.out.print("국어1: ");
		kor1 = scan.nextInt();
		
		int validate = (0<=kor1 && kor1<=100)?0:1;
		System.out.println(validate);
		
		
		
		
		
		
	}

}

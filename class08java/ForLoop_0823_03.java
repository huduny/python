package homeworks;

import java.util.Scanner;

public class ForLoop_0823_03 {

	public static void main(String[] args) {
		// 사용자로부터 5과목의 점수를 입력받아 평균을 구하는 프로그램을 작성하여 보자. 
//		평균 점수로 학점을 계산하여 출력한다.(평균 점수는 소숫점 둘째자리까지만 출력)
//		평균 점수가 90점 이상이면 A, 80점 이상 90점 미만이면 B, 70점 이상 80점 미만이면 C, 60점 이상 70점 미만이면 D, 60점 미만이면 F로 계산한다.
//		변수
		Scanner scn = new Scanner(System.in);
		char grade;
//		input
		System.out.println("점수를 입력하세요");
		
		System.out.print("프로그래밍 기초: ");
		int GProgram = scn.nextInt();
		System.out.print("데이터베이스: ");
		int GData = scn.nextInt();
		System.out.print("화면구현: ");
		int GDisplay = scn.nextInt();
		System.out.print("애플리케이션구현: ");
		int GApp = scn.nextInt();
		System.out.print("머신러닝: ");
		int GMachine = scn.nextInt();
		
//		process
		int TotalScore = GProgram + GData + GDisplay + GApp + GMachine;
		double Average = (double) (TotalScore / 5);
		
		
		
//		output
		if (Average>=90) {
			grade = 'A';
		} else if (Average>=80 && Average<90) {
			grade = 'B';
		} else if (Average>=70 && Average<80) {
			grade = 'C';
		} else if (Average>=60 && Average<70) {
			grade = 'D';
		} else {
			grade = 'F';
		}
		
		System.out.println("총점: " + TotalScore);
		System.out.println("평균: " + Average);
		System.out.println("학점: " + grade);
		
		
		
	}

}

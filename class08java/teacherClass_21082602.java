package homeworks_08M;

import java.util.Random;
import java.util.Scanner;

public class teacherClass_21082602 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		인공지능 컴퓨터와 게이머(사람)가 가위바위보 게임을 할 수 있도록 프로그램을 작성하시오.
		Scanner scn = new Scanner(System.in);
		Random ran = new Random();
		String[] ai = {"가위", "바위", "보"};
		String[] lastResult = {"게이머 승리", "AI 승리", "무승부 입니다"};
//		String[] ai = ai[ran.nextInt(3)]; 인덱스 숫자를 nextint로 받아준다.
		int i;
		
//		랜덤은 숫자로 나오지 문자로 나오지 않는다
		System.out.print("가위 바위 보를 입력하세요: ");
		String man = scn.next();
		System.out.println("게이머: "+ man);
		
		i = ran.nextInt(3);
		System.out.println("인공지능 컴퓨터: " + ai[i]);
		
		if (ai[i].equals(man)) {
			System.out.println(lastResult[2]);
		}else if((man.equals("주먹")&&i==0)||
				(man.equals("보")&&i==1)||(man.equals("가위")&&i==2)) 
		{
			System.out.println(lastResult[0]);
		}else 
		{
			System.out.println(lastResult[1]);
		}
			
		
		
		scn.close();

	}

}

package homeworks_08M;

import java.util.Scanner;

public class References_0825_01_teacher06 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		boolean run = true;
		int studentNum = 0;
		int[] scores = null;
		Scanner scanner = new Scanner(System.in);
		
		while(run) {
			System.out.println("-----------------------------------------------");
			System.out.println("1.학생수| 2.점수입력| 3.점수리스트| 4.분석| 5.종료");
			System.out.println("-----------------------------------------------");
			System.out.print("선택> ");
			
			int selectNo = scanner.nextInt();//숫자만 가져와서 변환한다, 엔터를 떠넘긴다. 그래서 nextline을 그다음에 쓰면 엔터를 인식해서 값을 입력 못한다
//			nextint와line을 같이 사용할려면 int 뒤에 line을 한번더 써서 엔터를 제거하는 작업이 필요할 수도 있다.
			
			if(selectNo ==1) {
				System.out.print("학생수> ");
				studentNum = scanner.nextInt(); //scores의 초기값을 받기 위해 학생수를 입력 받는다.
				scores = new int[studentNum]; //배열 초기화
				
			}else if (selectNo ==2) {
				for (int i = 0; i < (scores.length); i++) {
					System.out.print("scores["+(i+1)+"]> ");
					scores[i] = scanner.nextInt(); //배열에 값을 입력

				}
			}else if (selectNo ==3) {
				for (int i = 0; i < scores.length; i++) {
				System.out.println("scores["+(i+1)+"]> "+scores[i]);
				}
				
				
			}else if (selectNo ==4) {
				int max = Integer.MIN_VALUE;
				int sum = 0;
				double avg =0;
				
				for (int i = 0; i < scores.length; i++) {
					//최고 점수
					if (max < scores[i]) {
						max = scores[i];}
					//합계 구하기
					sum +=scores[i];
					}
				avg = (double) sum/studentNum;
				System.out.println("max: " + max);
				System.out.println("평균 점수: " + avg);
				
			}else if (selectNo ==5) {
				run = false;
			}
		}
		
		System.out.println("프로그램 종료");
		scanner.close();
	}

}

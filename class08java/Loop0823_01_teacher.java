package CHAPTER4;

import java.util.Scanner;

public class Loop0823_01_teacher {
		boolean run = true;
		int balance = 0;
		Scanner scn = new Scanner(System.in);
		
		
		    while (run) {
//			String choice;
			System.out.println("----------------------------");
			System.out.println("1.예금 | 2.출금 | 3.잔고 | 4.종료");
			System.out.println("----------------------------");
			System.out.print("선택> ");
			int menu = scn.nextInt();
			switch (menu) {
			case 1:
				System.out.println("예금액> ");
				balance +=scn.nextInt();
				break;
			case 2:
				System.out.println("출금액> ");
				balance -=scn.nextInt();
				break;
			case 3:
				System.out.println("잔고> " + balance);
				break;
			case 4:
				break;
			}
			
			System.out.println("프로그램 종료");
			
			
		    }
	}

}

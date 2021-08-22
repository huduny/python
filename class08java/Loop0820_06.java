package CHAPTER4;

import java.util.Scanner;

public class Loop0820_06 {

	public static void main(String[] args) {
		// 예금 입금 출금
		boolean run = true;
		int balance = 0;
		Scanner scn = new Scanner(System.in);
		
		
		    while (run) {
//			String choice;
			System.out.println("----------------------------");
			System.out.println("1.예금 | 2.출금 | 3.잔고 | 4.종료");
			System.out.println("----------------------------");
			System.out.print("선택> ");
			
			int choice = Integer.parseInt(scn.nextLine());
			
				if(choice == 1) {
					System.out.print("예금액> ");
					int deposit = Integer.parseInt(scn.nextLine());
					balance += deposit ;
					continue; }
				
				if(choice == 2) {
					System.out.print("출금액> ");
					int withdraw = Integer.parseInt(scn.nextLine());
					balance -= withdraw ;
					continue;}
				
				if(choice == 3) {
					System.out.print("잔고> " + balance + "\n");
					continue; }
				
				else {
					break ;
			}
			
		}
		System.out.println("프로그램 종료");	
		scn.close();
		}
		
		
		

	}



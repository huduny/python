package CHAPTER4;

import java.util.Random;

public class WhilePrintExample0820 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		int i = 1;
//		while (i<=10) {
//			System.out.println(i);
//			i++;
//		}
//		int sum = 0;
//		int i = 0;
//		for(i=1; i<=10000000000000L; i++) {
//			sum += i;} //sum=sum+i}
//		System.out.println("1~100 합: " + sum);
//		
//		int sum = 0;
//		int i = 1;
//		while(i<=100) {
//			sum += i;
//			i++;
//		}
//		System.out.println("1~" + (i-1) + "합: " +sum);
//		
//		while(true) {
//			//조건식
//			//break, continue
//		}
		Random ran = new Random();
		
		while (true) {
			int num = ran.nextInt(6) + 1;
			System.out.println(num);
			if (num == 6) {
				break;
			}
		}
		System.out.println("시스템이 종료되었습니다.");
		
		
		
		
	}

}

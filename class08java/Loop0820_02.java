package CHAPTER4;

import java.util.Random;

public class Loop0820_02 {

	public static void main(String[] args) {
		//while random메소드 이용 2개 주사위
		//눈1 눈2 형태로 출력
		//눈의 합이 5가 아니면 계속 주사위
		//눈의 합이 5이면 실행 멈춤
		//5는 14 41 23 32
//		변수
		Random ran = new Random();
		
//		처리
		while (true) {
			int a = ran.nextInt(6)+1;
			int b = ran.nextInt(6)+1;
			System.out.println("눈의 합이 5가 되는 조합은" + "(" + a + ")" + "(" + b +")");
			
			if(a+b == 5) {
			 break;
			}
		}
//		출력	


		
		
	}

}

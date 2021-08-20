package CHAPTER4;

public class BreakOutter0820_02 {

	public static void main(String[] args) {
//		for (int i = 1; i <= 10; i++) {
//			if(i%2 != 0) {
//				continue;
//			}
//			System.out.println(i);
//		}
//		1~100 홀수의 합
	
		int sum = 0;
		for (int i =1; i <= 100; i++) {
			if(i%2 == 0) {
				
			}
			sum += i;
			
		}
			System.out.println("홀수 합계는: " + sum + "입니다.");
		
		
			
	}

}


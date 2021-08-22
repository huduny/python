package CHAPTER4;

import java.util.Random;

public class randomExample {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		클래스 객체를 사용할려면 반드시 만들어야 된다
		Random random = new Random(88); // ctral+1하면 assign 된다
		//random뒤에()아무것도 안쓰면 실행되는 시각에 랜덤이 결정된다
		//long seed 시드는 씨앗, 여기에 어떤 것을 넣으면 그값에 따라서 똑같은 값이 나온다.
//		random.nextInt(10); //int bound, 10이라고 쓰면 0~9까지
//		alt+shift+a를 누르면 세로모드가 된다
		int ranNum1 = random.nextInt(100); 
		int ranNum2 = random.nextInt(100);
		int ranNum3 = random.nextInt(100); 
		int ranNum4 = random.nextInt(100); 
		int ranNum5 = random.nextInt(100);
		int ranNum6 = random.nextInt(100); 
		int ranNum7 = random.nextInt(100); 
		
		System.out.println(ranNum1);
		System.out.println(ranNum2);
		System.out.println(ranNum3);
		System.out.println(ranNum4);
		System.out.println(ranNum5);
		System.out.println(ranNum6);
		System.out.println(ranNum7);
		
//		random.nextInt(66) + 35; // 35~100까지
		

	}

}

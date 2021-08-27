package chapter04;

import java.util.Random;

public class Exercise4_7 {

	public static void main(String[] args) {
		// 4-7번
		Random ran = new Random();
//		int value = ran.nextInt(6)+1;
		int value = (int)(Math.random()*6)+1;
		

		System.out.println("value: "+value);

	}

}

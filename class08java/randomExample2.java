package CHAPTER4;

import java.util.Random;

public class randomExample2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		// if안에 if를 넣는 중복중첩이 가능하다
		Random ran = new Random();
		
		System.out.println("당첨 번호는: ");
		int num = ran.nextInt(6)+1;
		
		if (num==1) {
			System.out.println("1번이 나왔습니다.");
			
		} else if (num==2) {
			System.out.println("2번이 나왔습니다.");
		} else if (num==3) {
			System.out.println("3번이 나왔습니다.");
		} else if (num==4) {
			System.out.println("4번이 나왔습니다.");
		} else if (num==5) {
			System.out.println("5번이 나왔습니다.");
		} else {
			System.out.println("6번이 나왔습니다.");
		}
		
		
		
		
	}

}

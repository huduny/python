package CHAPTER4;

import java.util.Random;

public class randomswitch1 {

	public static void main(String[] args) {
	Random ran = new Random();
	
	int num = ran.nextInt(6) + 1;
	
	switch (num) {
	case 1:
		System.out.println("1번이 나왔습니다.");
		break;
	case 2:
		System.out.println("2번이 나왔습니다.");
		break;
	case 3:
		System.out.println("3번이 나왔습니다.");
		break;
	case 4:
		System.out.println("4번이 나왔습니다.");
		break;
	case 5:
		System.out.println("5번이 나왔습니다.");
		break;
	default:
		System.out.println("6번이 나왔습니다.");
		break;
	}
	//switch에는 string이나 char, int 타입만 된다, 자바에서 실수는 부동소수점으로 관리 타입이 다르면 다르게 나타낸다
	
	}

}

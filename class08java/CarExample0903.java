package CHAPTER7;

import java.util.Iterator;

public class CarExample0903 {
	public static void main(String[] args) {
		Car0903 car = new Car0903();
		
		for (int i = 1; i <= 5; i++) {
			
			int problemLocation = car.run();
			
			switch (problemLocation) {
			
			case 1:
				System.out.println("앞 왼쪽 HanKookTire로 교체");
				car.frontLeftTire = new HankookTire0903(15, "앞왼쪽");
				break;
			case 2:
				System.out.println("앞 오른쪽 KumhoTire로 교체");
				car.frontRightTire = new KumhoTire0903(13, "앞왼쪽");
				break;
			case 3:
				System.out.println("뒤 왼쪽 HanKookTire로 교체");
				car.backLetfTire = new HankookTire0903(14, "앞왼쪽");
				break;
			case 4:
				System.out.println("뒤 오른쪽 KumhoTire로 교체");
				car.backRightTire = new KumhoTire0903(17, "앞왼쪽");
				break;
			}
			System.out.println("------------------------------------");
//			타이어 타입을 상속 받은 필드의 다형성, 타입은 어떤 역할을 한다
		}

	}
}

package CHAPTER6;

public class CarExample210826 {

	public static void main(String[] args) {
		//객체 생성
		Car210826 myCar = new Car210826();
//		같은 패키지 안에 있으면 임폴트를 안해도 된다. 다른 패키지 않에 있으면 해야된다.
		
		//필드값 dlfrrl
		System.out.println(myCar.company);
		System.out.println(myCar.model);
		System.out.println();
		System.out.println();
		System.out.println();
		
		//필드값 변경
		myCar.speed = 60;
		System.out.println(myCar.speed);

	}

}

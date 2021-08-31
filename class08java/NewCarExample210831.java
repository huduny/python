package homeworks_08M;

public class NewCarExample210831 {

	public static void main(String[] args) {
		Car210831 myCar = new Car210831("red");
		System.out.println("myCar의 색: " + myCar.getColor());
		System.out.println("차의 최대 속력: " + Car210831.getMaxSpeed()+"km/h");

		System.out.print("첫 번째 speedUp(100.0km/h): ");
		if (myCar.speedUp(100.0)) {
			System.out.print("속변 가능, ");
		}else {
			System.out.print("속변 불가, ");
		}
		System.out.println("현차 속력: "+myCar.getSpeed()+"km/h");
		
		System.out.print("첫 번째 speedUp(90.0km/h): ");
		if (myCar.speedUp(90.0)) {
			System.out.print("속변 가능, ");
		}else {
			System.out.print("속변 불가, ");
		}
		System.out.println("현차 속력: "+myCar.getSpeed()+"km/h");
		
		Car210831 yourCar = new Car210831("blue");
		System.out.println();
		System.out.println("yourCar의 색: " + yourCar.getColor());
		System.out.println("차의 최대 속력: " + Car210831.getMaxSpeed()+"km/h");
		
		System.out.print("첫 번째 speedUp(-100.0km/h): ");
		if (yourCar.speedUp(-100.0)) {
			System.out.print("속변 가능, ");
		}else {
			System.out.print("속변 불가, ");
		}
		System.out.println("현차 속력: "+yourCar.getSpeed()+"km/h");
	
		System.out.print("첫 번째 speedUp(210.0km): ");
		if (yourCar.speedUp(210.0)) {
			System.out.print("속변 가능, ");
		}else {
			System.out.print("속변 불가, ");
		}
		System.out.println("현차 속력: "+yourCar.getSpeed()+"km/h");
	
	} // 메인
	
} // 클래스
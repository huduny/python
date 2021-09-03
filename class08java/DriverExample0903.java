package CHAPTER7;

public class DriverExample0903 {
	public static void main(String[] args) {
		Driver0903 driver =new Driver0903();
				
		driver.drive(new Bus0903());
//		똑같다 주소값을 넣는거기 때문에
		driver.drive(new Taxi0903());
//		vehicle타입인데 버스를 넣었따 Vehicle vehicle = new Bus();로 된다.
//		그 주소에 있는 런이라는 메소드를 호출하면 택시 run 버스 run 등이 호출된다
//		변수의 타입 선언은 생성된 객체보다 같거나 상위 타입을 선언할수 있다.
//		()안에 매개변수에 들어 갈 수 있는 타입은 같거나 하위 타입이 들어올 수 있다.
//		변수 타입은 상위 타입, 매개변수 안에는 하위 타입을 선언하면 다형성을 충족할 수 있다.
//		Vehicle v = new Bus();//자동 타입 변환
//		Bus b =(Bus) new Vehicle//강제 타입 변환, 에러발생, 
//		부모가 위에 있지만 실제적인 코드의 수는 자식이 더 많다.
//		따라서 캐스팅하기 전에 환경 조건을 따진다
		Vehicle0903 vehicle = new Vehicle0903();
		if (vehicle instanceof Bus0903) {
			Bus0903 b = (Bus0903) vehicle;
			System.out.println("변환되었습니다");
//		버스라는 타입의 인스턴스가 될수 있냐
		}else {
			System.out.println("변환안됨ㄴ");
		}
	
	}
	
	
	
	
}

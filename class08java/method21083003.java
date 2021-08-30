package CHAPTER6;

public class method21083003 {
//	계산기
	
//	power on
	void powerOn(){
		System.out.println("전원을 켭니다.");
	}
//	동작
	int plus(int x, int y) {
		int result = x+y;
		return result;
		
	}
	int subtract(int x, int y) {
		int result = x-y;
		return result;
	}
	double divide(int x, int y) {
		double result = (double)x/(double)y;
		return result;
	}
	int multiple(int x, int y) {
		int result = x*y;
		return result;
	}
	double avg(int x, int y) {
		double  sum = plus(x,y);
		double result = sum/2;
		return result;
	}
	void execute() {
		double  result = avg(7,10);
		println("실행결과: "+ result);
	}
	void println(String message) {
		System.out.println(message);
	}
	double areaRectangle(double width) {
		return width * width;
	}
	double areaRectangle(double width, double height) {
		return width * height;
	}
//	power off		
	void powerOff() {
		System.out.println("전원을 끕니다.");
	}
//	클래스를 정의한거다.
//	클래스 내부에서 호출할때는 별도로 선언할 필요가 없이 사용할 수 있다.
//	외부에서 호출할때는 new를 통해 만든다
//	실행 순서(2문제) 시험문제이다.***
//	static이 안붙어있는데에서는 static을 사용할수 있지만 static이 있는 곳에서는 static이 없는 곳을 쓸수 없다
//	총문제는 10문제
//	손코딩

}

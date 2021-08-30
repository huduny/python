package CHAPTER6;

public class method21083001 {

//		계산기
		
//		power on
		void powerOn(){
			System.out.println("전원을 켭니다.");
		}
//		동작
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

//		power off		
		void powerOff() {
			System.out.println("전원을 끕니다.");
		}
//		클래스를 정의한거다. 

}

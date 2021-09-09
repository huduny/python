package CHAPTER10.chapter10_1;

public class TryCatchFinallyRuntimeExceptionExample {
	public static void main(String[] args) {
		String data1 = null; //data1을 선언하고 null로 초기화 하는 것이다. 항상 변수는 초기화를 해줘야 된다.
		String data2 = null; //스프링에 예외처리 클래스가 있다. 모듈화가 되어 있다.
//		alt+shift+z단축키
		try {
			data1 = args[0];
			data2 = args[1];
			
		} 
		catch(ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
			System.err.println("실행 매개값의 수가 부족합니다."); //(err:빨강색, out:검은색)
			return; //수업을할때 sysout절대 사용하지 말자
		}
		try {
			int value1 = Integer.parseInt(data1);
			int value2 = Integer.parseInt(data2);
			int result = value1 + value2;
			System.out.println("숫자로 변환할 수 없습니다");
		} 
		catch(NumberFormatException e) {
			e.printStackTrace();
			System.out.println("숫자로 변환 못해");
		} 
		finally {
			System.out.println("다시 실행 핫요");
		}
		
		
		
		
	}
}

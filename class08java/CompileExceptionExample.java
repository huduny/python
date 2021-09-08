package CHAPTER10.chapter10_1;

public class CompileExceptionExample {
	public static void main(String[] args) {
		try {
			Class.forName("java.lang.String");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //컴파일타임에러
//		try 실행해라 근데 catch안의 에러가 발생하면 잡아서 중괄호를 실행해라
		String s = null;
		s.equals("b");//런타임에러
	}
}

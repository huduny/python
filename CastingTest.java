package kr.or.ddit;

public class CastingTest {

	public static void main(String[] args) {
		
		double a = 1.1;
		double b =	11;
		System.out.println(b);
		
	//	int c = 1.111;
	//	System.out.println(d);
		int d = (int) 1.111;
		double e = 1.111;
		System.out.println(d);
		System.out.println(e);
		
		String f = Integer.toString(1);
		System.out.println(f.getClass());
		
		
		
	}

}

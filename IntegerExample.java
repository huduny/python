package Chapter02;

public class IntegerExample {

	public static void main(String[] args) {
		// 정수 타입: byte, short, int, long
		// 문자타입: char(자바 내부적으로는 정수로 관리하지만
		// 보여줄때는 문자료 표현, 2바이트)	
		// Integer Literal
		int var1 = 0b1011; 	//0b or 0B 2진수
		int var2 = 0206; 	//0 8진수
		int var3 = 365; 	// 10진수
		int var4 = 0xB3; 	//0x or 0X 16진수
		
		System.out.println(var1);
		System.out.println(var2);
		System.out.println(var3);
		System.out.println(var4);
		System.out.println(7 % 3);
		System.out.println(3 % 7);
		                                                                                                                                                                                            
		int i = 0;
		int j = 10;
		i++;
		j--;
		
		System.out.println(i);
		System.out.println(j);
		
		byte var5 = -128;
		byte var6 = -30;
		byte var7 = 0;
		byte var8 = 30;
		byte var9 = 127;
		int var10 = 128;
		System.out.println(var5);
		System.out.println(var6);
		System.out.println(var7);
		System.out.println(var8);
		System.out.println(var9);
		System.out.println(var10);
		
		// long
		long var11 = 10;
		long var12 = 20;
		long var13 = 100_000_000_000L; // -21억 ~ 21억
		System.out.println(var11);
		System.out.println(var12);
		System.out.println(var13);
		
		int is = 3;
		boolean isOdd = is % 2 == 1;
		System.out.println(isOdd);
		
	}

}

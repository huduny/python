package chapter03;

public class Exercise3_8 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		/*
		 * 이항연산은 두 피연산자의 타입을 일치 시킨 후 연산 수행
		 * int보다 작은 타입은 int로 자동 변환
		 * byte short int long
		 * public 접근제한자, 언제든지 접근 가능
		 * static은 메모리에 미리 올림
		 * void는
		 * args는 파라미터
		 */
		byte a = 10;
		byte b = 20;
		
		/*
		 * 변수 a와 b는 모두 byte타입, 덧셈 연산 전에 int타입으로 자동 형변환
		 * int+int는 결과도 int
		 * int타입은 (4바이트), 바이트 타입은 (1바이트)에 담으려면 형변환이 필요함
		 * 
		 */
		byte c =(byte) (a+b);
		
		/*
		 * 'A'는 문자, 'a'는 문자열
		 * char타입이 덧셈연산을 하면서 int타입으로 자동형변환됨
		 * char타입의 변수(1byte)에 저장하려면 char타입으로 형변환(4->1)해야함
		 */
		char ch = 'A';
				ch = (char) (ch +2);
		/*
		 * int형을 int로 나누면 int
		 * 연산결과를 실수형으로 얻으려면 적어도 두 피연산자 중 한쪽이 실수형이어야 함
		 */
				
		float f = 3/2f;
		System.out.println(f);
		/*
		 * int*int*int는 int형이 나온다
		 * int형은 2*10의 9제곱 범위까지 가능 넘으면 오버플로우
		 */
		long l = 3000 * 3000 * 3000l;
		System.out.println(l);
		/*
		 *피연산자중 적어도 하나는 long타입이어야 한다
		 */
		
		float f2 = 0.1f;
		double d = 0.1;
		
		boolean result = (float) d==f2;
		System.out.println(result);
		/*
		 * 실수는 정수와 달리 근사값으로 표현을 함
		 * bouble ==floar =>double == double
		 * float를 double로 형변환 시 오차가 발생할 수 있다
		 * double을 오히려 float로 형변환
		 */
		int i;
		float f3 = 0f;
		
		for (int j = 0; j < 100; j++) {
			f3 += 0.1;
			
		}
		
		System.out.println(f3);
	}

}

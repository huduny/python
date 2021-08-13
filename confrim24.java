package Chapter02;

public class confrim24 {

	public static void main(String[] args) {
		// var1부터 var4까지 + 여ㅓㄴ산을 수행해서
		// int 타입의 result 변수에 9가 저장되도록 물음표(?)에 들어갈 코드를 작서
		
		long var1 = 2L;
		float var2 = 1.8f;
		double var3 = 2.5;
		// 문자형인 숫자를 숫자형으로 변환할때
		// Integer.parseInt("4") = 4 (정수형태를 정수형으로)
		// Double.parseDouble("4.9") = 4.9 (더블타입을 더블로)
		String var4 = "3.9";
		int result = (int) (var2 + var2 + (int) var3 + Double.parseDouble(var4));
		System.out.println(result);
		//데이터의 종류에 따라서 어떻게 변환이되고 나오는지 알아보는 사항이다
	}

}

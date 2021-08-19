package homeworks;

import java.util.Scanner;

public class operatorhk02 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);

		//입력 부분
		System.out.print("수도 입니까?(수도: 1, 수도아님: 0) ");
		int capital = sc.nextInt();
		System.out.print("총 인구는?(단위: 만) ");
		int population = sc.nextInt();
		System.out.print("연소득이 1억 이상인 인구는?(단위: 만) ");
		int highPopulation = sc.nextInt();
		
//		//처리 부분
		
		String result = (capital == 1 && population >= 100) || (highPopulation >= 50)? "입니다." : "가 아닙니다.";

		//출력 부분
		System.out.println("이 도시는 메트로 폴리스" + result);
		
		sc.close();
		
	}

}

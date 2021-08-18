package CHAPTER3;

import java.util.Scanner;

public class counter_0818 {

	public static void main(String[] args) {
//		a=a+5/a+=5(코드를 줄이기 위해서)
//		int result = 0; //초기화 및 선언
//		result += 10; 
//		System.out.println("result=" + result);
//		result -=5;
//		System.out.println("result=" + result);
//		result *=3;
//		System.out.println("result=" + result);
//		result /= 5;
//		System.out.println("result=" + result);
//		result %= 3;
//		System.out.println("result=" + result);
//		
//		int num = 0
//				num++; 먼저 메모리에서 값을 가져온 다음에 하나가 증가한다
//				++num; 먼저 연산에서 1을 증가하고 그다음에 메모리로 가져온다
		
//		int x = 10;
//		int y = 10;
//		int z;
//		
//		System.out.println("-----------------");
//		x++;
//		++x;
//		System.out.println("x=" + x);
//		
//		System.out.println("-----------------");
//		y--;
//		--y;
//		System.out.println("y=" + y);
//		
//		System.out.println("-----------------");
//		z=x++;
//		System.out.println("z=" + z);
//		System.out.println("x=" + x);
//		
//		System.out.println("-----------------");
//		z=++x;
//		System.out.println("z=" + z);
//		System.out.println("x=" + x);
//		
//		System.out.println("-----------------");
//		z=++x + y++;
//		System.out.println("z=" + z);
//		System.out.println("x=" + x);
//		System.out.println("y=" + y);
		
//		삼항연산자는 조건문과 비슷 , 어떤 조건에 따라서 값을 다르게 저장하고 싶을때
//		방법은 ?와 :을 사용(참,거짓)참일때는 앞에 있는 값 출력
				
//		int score = 95;
//		char grade = (score < 90) ? 'A':(score > 100) ? 'B':'C'; 
//		System.out.println(grade);
//		
//		int score = 105;
//		char grade;
//		if (score < 90) {
//			grade = 'a';
//			System.out.println(grade);
//		}
//			if (score > 100) {
//			grade = 'b';
//			System.out.println(grade);
//		}
//				else{
//			grade = 'c';
//			System.out.println(grade);
//		}
//		괄호는 없어도 된다
		
//		3번
//		boolean stop = true;
//		while(stop = false) {
//		}
//		while 안에 참값이 들어오면 반복을 계쏙하고 거짓이 들어오면 멈춘다 
//		4번
//		int pencils = 543;
//		int students = 30;
//		
//		int pencilsPerStudnet = pencils / students;
//		System.out.println(pencilsPerStudnet);
//		
//		int pencilsLeft = pencils % students ;
//		System.out.println(pencilsLeft);
		
//		6번
//		int value = 356;
//		System.out.println(value-56);
//		
//		int vale = 326;
//		System.out.println(vale - (vale % 100));
//		
//		int vale = 326;
//		System.out.println(vale/100*100);
		
//		8번
//		int lenghtTop = 5;
//		int lenghthBottom =10;
//		int height = 7;
//		double area = ((lenghtTop+lenghthBottom)*height*0.5);
//		System.out.println(area);
		
//		9번 
//		Scanner sc = new Scanner(System.in);
//		
//		System.out.println("첫 번째 수를 입력하세요");
//		double first = sc.nextDouble();
//		
//		System.out.println("두 번째 수를 입력하세요");
//		double second = sc.nextDouble();
//		String result = (num2 == 0 || num2 == 0.0) ?"무한대": num1/num2 +"";
//		num1/num2는 숫자 타입이고 string은 문자여서 +""를 해줘서 문자로 타입을 변환한다
		
//		System.out.println("결과: " + String.format("%.2f", results));
		
//		if (second == 0 || second == 0.0) {
//			System.out.println("결과: 무한대");
//		}
//			else {
//		double results = first / second;
//		
//		System.out.println("첫 번째 수: " + first);
//		System.out.println("두 번째 수: " + second);
//		System.out.println("----------------------------------");
//		
//	
//		System.out.println("결과: " + String.format("%.2f", results));
//		}
//		scanner.close();
		
//		11번
//		Scanner scanner = new Scanner(System.in);
//		
//		System.out.print("아이디:");
//		String name = scanner.nextLine();
//		
//		System.out.print("비번:");
//		String strPassword = scanner.nextLine();
//		int password = Integer.parseInt(strPassword);
//		
//		if(name.equals( "java")) {
//		name의 값에 null이 들어가면 equals를 못쓴다. 에러가 발생할 가능성이 있어서 "java".equals(name)으로 쓴다. null이 들어와도 메쏘드 사용가능
//		문자.equlas(비교할문자)
//		null관련 에러가 많아서 주의하자
//			if(password == 12345) {
//			System.out.println("로그인 성공");
//		} else{
//			System.out.println("로그인 실패:패스워드가 틀림");
//	     } 
//		} else {
//			System.out.println("로그인 실패:아이디 존재하지 않음");
//		  }
//			
//		12번
//		
//		int var1 = 5;
//		int var2 = 2;
//		double var3 = (double) var1 / var2;
//		int var4 = (int) (var3*var2);
//		System.out.println(var4);
		
//		정수/정수는 int
//		정수/실수는 double타입
//		자바에서는 부동소수점 방식으로 실수를 표시 float과 double타입의 표현은 다르다
	
//		int var1=10;
//		int var2=3;
//		int var3=14;
//		double var4=var1*var1*Double.parseDouble(var2+"."+var3);
//		System.out.println(var4);
		
		
	}

}

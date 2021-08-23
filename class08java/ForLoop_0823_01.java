package homeworks;

import java.util.Scanner;

public class ForLoop_0823_01 {

	public static void main(String[] args) {
		// 사용자로부터 세 변의 길이를 입력받은 후, 입력받은 변의 길이로 삼각형을 입력 받을 수 있는지 판별하는 프로그램을 만들어 보자. 
//		삼각형을 판별하는 방법은 가장 긴 변의 길이가 다른 두 변의 길이의 합보다 작으면 삼각형을 만들 수 있다.
		Scanner scn = new Scanner(System.in);
		int ShortSum;
		int LongA;
		
		//입력
//		세변의 길이 입력
		System.out.print("삼각형의 첫번째 변의 길이를 입력: ");
		int LengthA = scn.nextInt();
		System.out.print("삼각형의 두번째 변의 길이를 입력: ");
		int LengthB = scn.nextInt();
		System.out.print("삼각형의 세번째 변의 길이를 입력: ");
		int LengthC = scn.nextInt();

		if (LengthA>LengthB) {
			if (LengthA>LengthC) {
				LongA = LengthA;
				ShortSum = LengthB+LengthC;
					if(LongA < ShortSum) {
						System.out.println("삼각형을 만들수 있습니다.");
					}else{
						System.out.println("삼각형을 만들수 없습니다.");}
			}}else if (LengthB>LengthA) {
				if (LengthB>LengthC) {
				LongA = LengthB;
				ShortSum = LengthA+LengthC;
				if(LongA < ShortSum) {
					System.out.println("삼각형을 만들수 있습니다.");
				}else{
					System.out.println("삼각형을 만들수 없습니다.");}
			}}else if (LengthC>LengthA) {
				if (LengthC>LengthB) {
				LongA = LengthC;
				ShortSum = LengthB+LengthA;if(LongA < ShortSum) {
					System.out.println("삼각형을 만들수 있습니다.");
				}else{
					System.out.println("삼각형을 만들수 없습니다.");}
				}}

		
//		if (((var1>var2)&&(va1>var3))&&(var1<(var2+var3))
//		else if
//		else if
//		else
//			못만든다.
		
		
		
	}
	}



package JAVA_YOUTUBE;

public class print_number1 {

	public static void main(String[] args) {
		
				int kor1, kor2, kor3;
				int total;
				float avg;
				
				kor1 =50;
				kor2 =60;
				kor3 =80;
				
				total = kor1 + kor2 + kor3;
				avg = total / 3.0f; 
				//1.float붙이기 형변환
				//2.f붙이기
				
				//-------------출력부분-----------------------------
				System.out.println("┌───────────────────────────────┐");
				System.out.print("└──────────\\성적출력\\─────────────┘\n");
				
				System.out.printf("%2$d, %3$d, %1$d\n", 1, 2, 3);
				//argument는 순서+$로 쓴다
				System.out.printf("%1$d, %1$d, %1$d\n", 1);
				//argu를 쓰면 똑같은 값을 3번 쓸 수 있다.
				
				
				
				System.out.printf("\t국어1 : %3d\n", kor1);
				System.out.printf("\t국어2 : %3d\n", kor2);
				System.out.printf("\t국어3 : %3d\n", kor3);
				System.out.printf("\t총점 : %3d\n", total);
				System.out.printf("\t평균 : %6.3f\n", avg);
				//평균은 %d를 쓰면 안된다
				//형식 지정자
				// %~f까지ㅏ 그 안에 argument index/flags(정렬 -1이면 왼쪽 정렬)/width/percision 정하기
				
//				System.out.print(80);
//				System.out.write(80);
//				printf는 포멧을 정하고 그안에 값을 넣을 수 있는 기능이 있다.
//			형식지정자	
//			%s 문자열
//			%d 정수(10진수)
//			%f 실수
//			%c 문자
//			&e 지수

		
		
		
		
		
		
		
	}

}

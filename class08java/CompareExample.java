package CHAPTER8.chapter8_2;

import java.util.Arrays;
import java.util.Comparator;
import java.util.Iterator;
import java.util.Random;

public class CompareExample {
	public static void main(String[] args) {
		String[] names = {
				"송을영", "오영균", "양두산", "최수지",
				"박인범", "김승현", "천서영", "길도연",
				"장인슬", "정수경", "황채아", "김나리",
				"김보경", "이상림", "최인수", "표기훈",
				"전승현", "구천모", "하성호", "전영준",
				"이춘희", "김은지", "나의정"};
		
				Random random = new Random(88);
				Student[] ss = new Student[23];
				int index=0;
				
				for (String name : names) {
					ss[index++]=new Student(name, random.nextInt(100)+1, random.nextInt(100)+1);
				}
				
				Arrays.sort(ss); //comparable 인터페이스가 구현되지 않으면 에러가 난다
				
				
				
//				출력
				for (Student s : ss) {
					System.out.println(s);
				}
				
				
//		Integer[] scores = {48, 92, 70, 81, 39, 54, 62, 78, 92, 95, 19, 8, 53, 48,
//				65, 45, 45, 24, 21, 12, 56, 89, 65};
		
////		Arrays.sort(scores);//=>오름차순 정렬
////		for (int i : scores) {
////			System.out.print(i+" ");
////		}
////		Comparator<T>//인터페이스, 비교기 
////		Arrays.sort(scores, new Mycomparator());
//		Arrays.sort(scores, new Comparator<Integer>() {
//
//			@Override
//			public int compare(Integer o1, Integer o2) {
//				if (o1>o2) {
//					return -1; //1이면 자리가 바뀐다.
//				}else if(o1 < o2) {
//					return 1; //-1자리가 안바뀐다.
//				}
//				return 0; //0그대로 자리가 안바뀐다.
//			}
//		});
//		for (Integer i : scores) {
//			System.out.print(i + " ");
//		}
//		
//		Arrays.sort(names);
//		for (String s : names) {
//			System.out.print(s+" ");//사전순으로 정렬String은 comparable 인터페이스를 구현해야 합니다.
//		}
//		comparator를 만들어서 대입
//		실무에서는 바로 인터페이스 객체를 생성해서 한다
		
		
		// scores 데이터를 내림차순으로 출력하시오.
//		int temp = 0;
//		for (int i = 0; i < scores.length; i++) {
//			for (int j = 0; j < scores.length; j++) {
//				if (scores[i]>scores[j]) {
//					temp=scores[i];
//					scores[i]=scores[j];
//					scores[j]=temp;		
//				}
//			}
//			
//		}
//		for(int i : scores) {
//				System.out.print(i+",");
//			}
//		
		
		
	}
	
	
}

package CHAPTER11.chapter11_02;

import java.util.*;

public class ArrayListExample {
	public static void main(String[] args) {
		List<String> list = new ArrayList<String>();// 스트링이라는 데이터 타입의 목록
//		generic 
//		이렇게 타입을 정해주면 안에는 string만 들어갈수 있다.
		list.add("java");
		list.add("jdbc");
		list.add("servlet/jsp");	
		list.add(2, "database"); // 2번째 인덱스에 값을 넣는다 
		list.add("ibatis");
		
		int size = list.size();
		System.out.println("총 객체수: "+ size);
		System.out.println();
		
		String skill = list.get(2);
		System.out.println("2: "+skill);
		System.out.println();
		
		for (int i = 0; i < list.size(); i++) {
			String str = list.get(i);
			System.out.println(i+":"+str);
			
		}
		System.out.println();
		
		list.remove(2);
		list.remove(2);
		list.remove("ibatis");
		
		for (int i = 0; i < list.size(); i++) {
			String str = list.get(i);
			System.out.println(i+":"+str);
		}
		
		
	}
}

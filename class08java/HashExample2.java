package CHAPTER11.chapter11_0915;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class HashExample2 {
public static void main(String[] args) {
	Set<Member> set = new HashSet<Member>();
	
	set.add(new Member("홍길동", 30));
	set.add(new Member("홍길동", 30));
	set.add(new Member("홍길동1", 30));
	
	System.out.println("총 객체수: "+set.size());
	
	map.entrySet(): 모든 엔트리 집합
	map.keySet(); 모든 키값들의 집합
	map.values(); 모든 값들의 집합
	
	
}
}

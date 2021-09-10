package CHAPTER11.chaper11_01;

import java.util.HashMap;

import com.sun.javafx.collections.MappingChange.Map;

public class KeyExample {
	public static void main(String[] args) {
		// ArrayList & HashMap => 가장 많이 사용함
		Map<Key, String> map = (Map<Key, String>) new HashMap<Key, String>();
//		해시맵은 키값으로 같은지 다른지 비교해주는데 해시코드에 정의된것으로 한다
//		해시키드가 정의되어 있지 않으면 주소 값으로 비교 
		map.put(key1, "홍길동");
		map.put(key2, "자바");
		
	}
	
	
	
}

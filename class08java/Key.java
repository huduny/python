package CHAPTER11.chaper11_01;

import java.util.Objects;

public class Key {
	private int number;
	
	public Key(int number) {
		this.number = number;
	}
	
	@Override
	public int hashCode() {
		return Objects.hashCode(number); //number가 hash코드로 변경된다. 같은 숫자면 같은 해시이다.
//		넘버가 없으면 주소로 해시코드를 생성해서 다를 수 밖에 없다.
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof Key))
			return false;
		Key other = (Key) obj;
		return number == other.number;
	}
	
	
}

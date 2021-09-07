package CHAPTER8.chapter8_1;

public interface RemoteControl {
//	상수
	int MAC_VOLUME = 100;
	int MIN_VOLUME = 0;
//	public static final 생략 가능
	
//	메소드
	void turnOn();
	void turnOff();
	void setVolume(int volume);
//	public abstract 안써도 된다.
	
//	메소드가 추상메소드 밖에 없다. 추상 클래스인데, 추상 클래스를 좀더 발전시키면 필드가 없다(상수만 있어서)
//	추상 메소드만 있다. 상수(필드 없음)+추상메소드만 존재=인터페이스로 변경 가능하다.
//	인터페이스는 상수와 추상 메소드만 갖는다.(jdk 1.8미만)
	
}

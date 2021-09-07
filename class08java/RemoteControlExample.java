package CHAPTER8.chapter8_1;

public class RemoteControlExample {

	public static void main(String[] args) {
		RemoteControl rc = new Television();
//		가능하면 상위 타입으로 선언하는게 좋다.
		rc.turnOn();
		rc.turnOn();
		
		rc = new Audio();
//		오디오도 remotecontrol의 자식이기 때문에 가능하다.
		rc.turnOn();
		rc.turnOn();
	}

}

package CHAPTER8.chapter8_1;

public class MyClass {
//	인터페이스를 통해서 통신을 한다
	//field
	RemoteControl rc = new Audio();
	public MyClass() {
		// TODO Auto-generated constructor stub
	}
	void Myclass(){}
	public void Myclass(RemoteControl rc) {
		this.rc=rc;
//				외부에서 입력한 값이 입력된다.ㄴ
		rc.turnOn();
		rc.setVolume(5);
	}
	void methodA() {
		RemoteControl rc = new Audio();
		rc.turnOn();
		rc.setVolume(5);
		
		
	}
	void methodB(RemoteControl rc) {
		rc.turnOn();
		rc.setVolume(5);;
	}
	
	
	
}

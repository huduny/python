package CHAPTER6;

public class getterSetter210831 {
//	데이터를 보호해야하기 때문에
//	
	private int speed;
	private boolean stop;
	
	public getterSetter210831(int speed, boolean stop) {
		this.speed = speed;
		this.stop = stop;
	}//생성하면서 값을 초기화할 수도 있다.
	
//	값을 가져오는것
	public int getSpeed() {
		return speed;
	}
	public boolean isStop() {
		return stop;
	}//불린은 트루나 펄스냐를 판단
//	값을 사용
	public void setSpeed(int speed) {
		if(speed <0) {
		this.speed = 0;
		return;
		}
		this.speed = speed;
	}
	public void setStop(boolean stop) {
		this.stop = stop;
		this.speed = 0;
	}
//	get set is를 많이 쓴다. private으로 필드를 선언하고
	
}

package CHAPTER8.chapter8_1;

public class Television implements RemoteControl {
	private int volume;

	@Override
	public void turnOn() {
		System.out.println("tv를 켭니다.");
		
	}

	@Override
	public void turnOff() {
		System.out.println("티비를 끕니다");
		
	}

	@Override
	public void setVolume(int volume) {
		if (volume > RemoteControl.MAC_VOLUME) {
			this.volume = RemoteControl.MAC_VOLUME;
			
		}else if ( volume < RemoteControl.MAC_VOLUME ) {
			this.volume = RemoteControl.MIN_VOLUME;
		}else {
			this.volume = volume;
		} System.out.println("현재 볼륨은: " + this.volume);
	
		
		
		
		
	}	

}

package homeworks_08M;

public class Time210831 {
	final private int hour;
	final private int minute;
	final private int second;
	
	
//	constructor
	public Time210831() {
	this.hour = 0;
	this.minute = 0;
	this.second = 0;
	}
	
	public Time210831 (int hour,int minute,int second) {
		if(0<=hour&& hour<=23) {
			this.hour = hour;
		}else {
			this.hour = 0;
		}
		if(0<=minute&& minute<=59) {
			this.minute = minute;
		}else {
			this.minute = 0;
		}
		if(0<=second&& second<=59) {
			this.second = second;
		}else {
			this.second = 0;
		}
	}
//	methods
	public String toString() {
		return String.format("%02d:%02d:%02d", hour, minute, second);
	}
	
}

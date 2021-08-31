package homeworks_08M;

public class Car210831 {
	//field
	private double speed;
	private String color;
	private final static double MAX_SPEED=200.0;
	
	//constructor
	Car210831( ) { }
	
	Car210831(String color) {
		this.color = color; }
	
	//method
	public double getSpeed() {
		return speed;
	}
	public void setSpeed(double speed) {
		this.speed = speed;
	}
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	public boolean speedUp(double speed) {
		if(speed < 0 || speed > Car210831.MAX_SPEED) {
			return false;
		}else {
			this.speed += speed;
			return true;
		}
		
	}
	
	public static double getMaxSpeed(){
		return MAX_SPEED;
	}
	
	public String toString() {
		return "";
	}
	
	
	
	
	
}

package homeworks_08M;

public class NewCar210831 {
		//field
		private double speed;
		private String color;
		private final static double MAX_SPEED=killoToMile(200.0);
		
		//constructor
		NewCar210831( ) { }
		
		NewCar210831(String color) {
			this.color = color; }
		
		//method
		public double getSpeed() {
			return killoToMile(speed);
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
			if(speed > killoToMile(NewCar210831.MAX_SPEED)) {
				return false;
			}else {
				this.speed += speed;
				return true;
			}
			
		}
		
		public static double getMaxSpeed(){
			return killoToMile(NewCar210831.MAX_SPEED);
		}
		
		private static double killoToMile(double distance) {
			distance = distance/1.6;
			return distance;
		}
		
		private static double mileToKillo(double distance) {
			distance = distance*1.6;
			return distance;
		}
		
		public String toString() {
			return "";
		}
	
	
	
	
	
	
	
}

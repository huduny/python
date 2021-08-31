package homeworks_08M;

public class Plane210831  {
//	fileds
	private String manufacture; 
	private String model;
	private int maxNumberOfPassengers;
	private static int numberOfPlanes;
	
//	constructor
	Plane210831() {
		this.manufacture = "";
		this.model = "";
		this.maxNumberOfPassengers = 0;
		numberOfPlanes++;}
	
	public Plane210831(String manufacture, String model, int maxNumberOfPassengers) {
		this.manufacture=manufacture;
		this.model=model;
		if(maxNumberOfPassengers<0) {
			this.maxNumberOfPassengers=0;
		}else{
			this.maxNumberOfPassengers=maxNumberOfPassengers;
		}
		numberOfPlanes++;
	}
	
//	methods
	public String getManufacture() {
		return manufacture;
	}
	public void setManufacture(String manufacture) {
		this.manufacture = manufacture;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model=model;
	}
	public int getMaxNumberOfPassenger() {
		return maxNumberOfPassengers;
	}
	public void setMaxNumberOfPassenger(int maxNumberOfPassengers) {
		if(maxNumberOfPassengers<0) {
			this.maxNumberOfPassengers=0;
		}else{
			this.maxNumberOfPassengers=maxNumberOfPassengers;
		};
	}
	public static int getNumberOfPlanes() {
		return numberOfPlanes;
	}
	public String toString() {
		return "";
	}
	
	
	
	
	
	
	
	
	
	
}

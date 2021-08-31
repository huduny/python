package homeworks_08M;

public class PlaneExample210831 {

	public static void main(String[] args) {
		Plane210831 plane1 = new Plane210831("보잉", "보잉 747", 450);
		System.out.println(plane1.getManufacture());
		System.out.println(plane1.getModel());
		System.out.println(plane1.getMaxNumberOfPassenger());
		System.out.println();
		
		Plane210831 plane2 = new Plane210831("보잉", "보잉 777", 500);
		System.out.println(plane2.getManufacture());
		System.out.println(plane2.getModel());
		System.out.println(plane2.getMaxNumberOfPassenger());
		System.out.println();
		
		Plane210831 plane3 = new Plane210831();
		plane3.setManufacture("록히드 마틴");
		plane3.setModel("f-22");
		plane3.setMaxNumberOfPassenger(-10);
		
		System.out.println(plane3.getManufacture());
		System.out.println(plane3.getModel());
		System.out.println(plane3.getMaxNumberOfPassenger());
		System.out.println();
		
		System.out.println(Plane210831.getNumberOfPlanes());
		
		

	}

}

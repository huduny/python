package homeworks09_07;

public abstract class Shape implements Comparable<Shape> {
	//String[] shapes;
	public Shape() {}
	
	public abstract double area(); 
	public abstract double perimeter();
	
	@Override
	public int compareTo(Shape o) {
//		return area().compareTo(o.area());

		if (area() >o.area()) {
			return 1;
		}else if ( area() == o.area()) {
			return 0;
		}else {
			return -1;
		}
		
	}
}


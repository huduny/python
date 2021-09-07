package homeworks09_07;

public class Triangle extends Shape {
	private double side;
	
	public Triangle(double side) {
		this.side = side;
	}
	@Override
	public double area() {
		return Math.sqrt(3)*side*side/4.0;
	}
	@Override
	public double perimeter() {
		return 3*side;
	}
	@Override
	public String toString() {
		return String.format("도형의 종류: 삼각형, [넓이=" + "%.2f" + ", 둘레=" + "%.2f" + "]", this.area(), this.perimeter());
	}

	
}
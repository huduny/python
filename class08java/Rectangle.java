package homeworks09_07;

public class Rectangle extends Shape {
	private double width;
	private double height;
	
	public Rectangle(double width, double height) {
		this.height = height;
		this.width = width;
	}
	@Override
	public double area() {
		return height*width;
	}
	@Override
	public double perimeter() {
		return (2*height)+(2*width);
	}
	@Override
	public String toString() {
		return String.format("도형의 종류: 사각형, [넓이=" + "%.2f" + ", 둘레=" + "%.2f" + "]", this.area(), this.perimeter());
	}
	
	
}

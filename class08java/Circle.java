package homeworks09_07;

public class Circle extends Shape{
	private double radius;
	
	public Circle(double radius){
		this.radius =radius;
	}
	@Override
	public double area() {
		return Math.PI*radius*radius;
	}
	@Override
	public double perimeter() {
		return 2*Math.PI*radius;
	}
	public String toString() {
		return String.format("도형의 종류: 원 [넓이=" + "%.2f" + ", 둘레=" + "%.2f" + "]", this.area(),this.perimeter());
	}

}

package homeworks_08M;

public class Circle0831 {
	
//	fields
	private double radius;
	private double x;
	private double y;
//	double area;
	
//	constructor
	Circle0831(){
	}
	
//	methods getsetx
	public double getX() {
		return x;
	}
	public void setX(double x) {
		this.x=x;
		return;
	}
//	methods getsety
	public double getY() {
		return y;
	}
	public void setY(double y) {
		this.y=y;
		return;
	}
//	methods getsetradi
	public double getRadius() {
		return radius;
	}
	public void setRadius(double radius) {
		if(radius<0) {
			this.radius = 0;
			return;
		}else {
			this.radius = radius;	
			return;
		}
	}
//	methods getarea
	public double getArea() {
		double area = this.radius*this.radius*Math.PI;
		return area;
	}
//	제한 타입 변수
}//class end

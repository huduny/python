package homeworks_08M;

public class circleExample0831 {

	public static void main(String[] args) {
		Circle0831 circle1 = new Circle0831();
		circle1.setRadius(3.6);
		circle1.setX(0.0);
		circle1.setY(1.5);
//		set은 값을 private에 넣는것
		
		System.out.println("반지름: "+circle1.getRadius());
		System.out.println("중심좌표: "+ circle1.getX()+','+ circle1.getY());
		System.out.printf("넓이: %.2f\n", circle1.getArea());
//		get은 값을 불러올려고
		
		Circle0831 circle2 = new Circle0831();
		circle2.setRadius(-5.0);
		circle2.setX(1.0);
		circle2.setY(2.2);
		
		System.out.println("반지름: "+circle2.getRadius());
		System.out.println("중심좌표: "+ circle2.getX()+ ','+circle2.getY());
		System.out.printf("넓이: %.2f\n", circle2.getArea());
	}//end main

}//end class

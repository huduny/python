package Chapter02;

//연산식에서 자동 타입 변환
public class operationpromotion {

	public static void main(String[] args) {
		//byte: -128~127
		//자바는 연산을 할때 int로 변환해서 연산을 한다.
		byte bv1 = 10;
		byte bv2 = 20;
		byte bv3 = (byte) (bv1 + bv2);
		int bv4 = (byte) (bv1 + bv2 + 10);
		System.out.println(bv3);
		System.out.println(bv4);
		
		
		char cv1 = 'A'; // 65
		char cv2 = 1;
		char cv3 = (char) (cv1 + cv2);
		int cv4 = cv1 + cv2;
		System.out.println(cv3);
		System.out.println(cv4);
		System.out.println((char)cv4);
		
		int iv3 = 10;
		int iv4 = iv3 / 4;
		System.out.println(iv4);
		
		int iv5 = 10;
		double dv = iv5 /(double) 4;
		System.out.println(dv);
	
		double dv1 = iv5 /4.0;
		System.out.println(dv1);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}

}

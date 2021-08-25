package homeworks_08M;

import java.util.Random;

public class ReferenceTypes_0825_04 {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		주사위를 던져서 각 면이 나오는 횟수를 출력하는 프로그램을 만들어 보자. 
//		주사위를 던지는 동작은 1부터 6까지의 임의로 만들어내는 난수 발생기(Random 객체)가 대신한다. 
//		난수 발생기를 10,000번 호출하여 각 면이 나타나는 횟수를 계산하여 배열에 저장한다. 
//		확률 이론에 의하면 주사위의 각각의 면들이 거의 동일한 횟수로 나와야 한다.
//		아래 그림과 똑같은 값이 나오지 않고 컴퓨터마다 값이 다르게 나오는 것이 정상이다.
		Random ran = new Random();
		int[] arrays = new int[6];
	
		
		for (int j = 0; j < 10000; j++) {
			int arraysNo = ran.nextInt(6)+1;
			
			switch(arraysNo){
				case 1:
					arrays[0] += 1;
					break;
				case 2:
					arrays[1] += 1;
					break;
				case 3:
					arrays[2] += 1;
					break;
				case 4:
					arrays[3] += 1;
					break;
				case 5:
					arrays[4] += 1;
					break;
				case 6:
					arrays[5] += 1;
					break;
			}

			
		}
		
		System.out.println("----------------");
		System.out.println("면          빈도");
		System.out.println("----------------");
		
		System.out.println(1+"           "+arrays[0]);
		System.out.println(2+"           "+arrays[1]);
		System.out.println(3+"           "+arrays[2]);
		System.out.println(4+"           "+arrays[3]);
		System.out.println(5+"           "+arrays[4]);
		System.out.println(6+"           "+arrays[5]);
		
	}
}

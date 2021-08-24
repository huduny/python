package CHAPTER5;

import java.text.DecimalFormat;

public class RefrenceType_0824_03 {

	public static void main(String[] args) {
		
		int[] scores = { 83, 90, 93, 92, 56};
		DecimalFormat dif = new DecimalFormat("#.##");
		
		int sum = 0;
		for (int i = 0; i < scores.length; i++) {
			sum += scores[i];
		}
		
		System.out.println("총합: " + sum);
		
		double avg =(double) sum/scores.length;
		
		String avg1=dif.format(avg);
		System.out.println("평균은: " + avg1);
		
		//int[] arr1 = new int[3], 은 arr1에 공간의 주소가 저장되어 있다. 자바에서는 배열을 만들때 초기 값을 만들어 준다.
	}

}

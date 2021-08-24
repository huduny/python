package CHAPTER5;

import java.text.DecimalFormat;

public class RefrenceType_0824_02 {

	public static void main(String[] args) {
		int[] scores = {83, 90, 87};
		
		System.out.println("scores[0]: " + scores[0]);

		int sum = 0;
		for (int i = 0; i < scores.length; i++) {
			sum +=scores[i];
		}
		System.out.println("총합: "+ sum);
		double avg = (double) sum/3;
		DecimalFormat df = new DecimalFormat("0.00");
		String avg1 = df.format(avg);
		System.out.printf("평균: "+ avg1);
	}
	

}

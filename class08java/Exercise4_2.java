package chapter04;

public class Exercise4_2 {

	public static void main(String[] args) {
		// 4-2번
		int sum=0;
		for (int i = 1; i <= 20; i++) {
			if(i%2==0 || i%3==0) {
				continue;
			
			}
			sum += i;
			
		}
		System.out.println(sum);
		
	}

}

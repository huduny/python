package CHAPTER4;

public class Loop0820_01 {

	public static void main(String[] args) {
		int sum = 0;
		for (int i = 1; i <= 100; i++) {
			if(i % 3 != 0) {
				continue;
				
			}
			sum += i;
		}
		System.out.println("3의배수 합은: " + sum);
	}

}

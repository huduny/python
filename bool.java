package Chapter02;

public class bool {

	public static void main(String[] args) {
		/*
		 * 논리형: boolean
		 * true false
		 * 
		 */
		boolean stop = true;
		if (stop) {
			System.out.println("중지합니다");
		} else {
			System.out.println("시작합니다");
		}
		int a = 4;
		int b = 6;
		if (a>b) {
			System.out.println("맞습니다");
		} 
		else {
			System.out.println("틀렸습니다");
		}
		int base = 190;
		int height = 213;
		boolean mytall = base > height;
		
		if(mytall) {
			System.out.println("you are so tall");
		}
		else {
			System.out.println("you are not tall");
		}

	}

}

package homeworks;

public class References_0824_04 {
	
	public static void main(String[] args) {
		
			int max = 0;
			int[] array = {1, 5, 3, 8, 2};
			
			//process
			for (int i = 0; i < array.length; i++) {
				if (max < array[i]) {
					max = array[i];
				}
			}
			
			//output
			System.out.println("max: " + max);
	
		
		
		
	
	
	
	}
 }

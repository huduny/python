package homeworks_08M;

public class ReferenceTypes_0825_01 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		다음 배열에서 최댓값과 최솟값을 구하시오.
//		{38, 94, 16, 3, 76, 94, 82, 47, 59, 8}
		int[] arrays = {38, 94, 16, 3, 76, 94, 82, 47, 59, 8};
		int max = Integer.MIN_VALUE;
		int min = Integer.MAX_VALUE;
		
		for (int i = 0; i < arrays.length; i++) {
			if(max < arrays[i]) {
				max = arrays[i];
			}
		}
		
		for (int i = 0; i < arrays.length; i++) {
			if(min > arrays[i]) {
				min = arrays[i];
			}
		}
		
		System.out.println("최댓값은: " + max);
		System.out.println("최솟값은: " + min);
		
	}

}

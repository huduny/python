package homeworks_08M;

public class References_0825_01_teacher05 {

	public static void main(String[] args) {
		int[][] array = {
				{95,86},
				{83,92,96},
				{78,83,93,87,88}
		};
		
		int sum =0;
		double avg = 0.0;
		
		int count = 0;
		for (int i = 0; i < array.length; i++) { // 바깥을 돌 즉 index를 돌 반복문 row
			for (int j = 0; j < array[i].length; j++) { // i번째 행에 가로방향 column을 돌 반복문 필요
				System.out.println("score["+i+"]["+j+"]"+array[i][j]);
				sum+=array[i][j];//원소의 값을 누적 00,01,10,11,12...24
//				count++;//카운트 숫자를 세준다
				avg =(double) sum/(array[0].length+array[1].length+array[2].length);
				}
			}
		
		
		
		System.out.println("sum: " + sum);
		System.out.println("avg: " + avg);
		
		
	}

}
package CHAPTER5;

public class RefrenceType_0824_05 {

	public static void main(String[] args) {
		// 다차원 배열
//		scores[2][1](행,열)
		
		int[][] mathScores = new int[2][3];
		for(int i =0; i<mathScores.length; i++) {
			for (int j = 0; j < mathScores[i].length; j++) {
				System.out.println(mathScores[i][j]);
			}
		}
		
		for (int[] is : mathScores) {
			//향상된 포문이다.
			//for each랑 같다.
			//인덱스를 쓰지말고 배열의 갯수 만큼 반복해서 하나씩 접근해 보자
		}
		

	}

}

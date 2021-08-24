package CHAPTER5;

public class RefrenceType_0824_06 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] scores = {95, 71, 84, 93, 87};
		for (int i = 0; i < scores.length; i++) {
			System.out.println(scores[i]);
		}
		for (int score : scores) {
//			i는 인덱스 i가 아니다, scores에서 꺼내서 담아준다
			System.out.println(score);
//			굳이 인덱스가 필요 없을 때는 이것을 많이 쓴다
//			:뒤에 배열 객체가 나오고=>타입변수에 저장=>실행문을 실행한다
		}
	}

}

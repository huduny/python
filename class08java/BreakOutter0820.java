package CHAPTER4;

public class BreakOutter0820 {

	public static void main(String[] args) {
		Outter: for (char upper = 'A'; upper <= 'Z'; upper++) {
			Inner: for (char lower ='a'; lower <= 'z'; lower++) {
				System.out.println(upper + "-" + lower);
				if (lower == 'g') {
					break Outter;//break는 소문자까지만 영향을 미친다, 이것을 해결하기 위해 for문에 alias(별명)(레이블)을 지어준다
				}
				
			}
			
			
			
		}

	}

}

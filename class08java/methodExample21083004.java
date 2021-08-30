package CHAPTER6;

public class methodExample21083004 {

	public static void main(String[] args) {
		method21083004 memberService = new method21083004();
		boolean result = memberService.login("hong", "12345");
		if(result) {
			System.out.println("로그인 되었습니다.");
			memberService.logout("hong");
		}else {
			System.out.println("id 또는 password가 올바르지 않습니다");
		}
		System.out.println("https:www.naver.com");
		
		double result5 = method21083005.pi*100;
		
	}
//		문자를 입력을 해두면 큰 차이가 없지만 scanner로 값을 입력 받으면 주소값이 달라지므로 문자를
//		비교할때는 항상 equals를 사용해 주자.
}

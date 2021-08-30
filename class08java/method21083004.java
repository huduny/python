package CHAPTER6;

public class method21083004 {
	boolean login(String id, String password) {
		if(id.equals("hong")&&password.equals("12345")) {
			return true;
		}else {
			return false;	
		}
	}
//	변수값을 먼저 넣는것보다
//	"hong".equals(id)로 쓰는게 좋다. 왜냐하면 null값이 들어가면 에러가 뜨기 때문이다.
//	불린 타입을 반환한다는 것은 결과가 참이면 트루가 나오고 아니면 펄스가 나오기 때문입니다.
//	return id.equals("hong")&&password.equals("12345"); 이렇게 쓸 수 있다.
	void logout(String id) {
		System.out.println("로그아웃되었습니다.");
		}
	
	
	
	
}

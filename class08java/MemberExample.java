package CHAPTER11.chapter11_0915;

import java.util.List;

public class MemberExample {
	public static void main(String[] args) throws Exception {
		memberDAO dao = new memberDAO();
		List<MemberVO> list = dao.getMemberList();
		for (MemberVO vo : list) {
			System.out.println(vo);
		}
	}
}

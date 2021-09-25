package com.ddit401.Bus_login.Console;

public class MemberService {
	private static MemberService instance = new MemberService();
	public static MemberService getInstance() {
		return instance;
	}
	private MemberService() {}
	
	MemberDao dao = MemberDao.getInstance();
	
	public MemberVO login(MemberVO vo) {
		return dao.login(vo);
	}
	public int inputNoticeMenu(MemberVO menu) {
		return dao.inputNoticeMenu(menu);
	}
}

package com.ddit401.Bus_login.Console;

public class MemberController {
	
	private static MemberController instance = new MemberController();
	
	public static MemberController getInstance() {
		return instance;
	}
	
	private MemberController() {}
	
	MemberService service = MemberService.getInstance();
	
	public MemberVO login(MemberVO vo) {
		return service.login(vo);
	}

	public int inputNoticeMenu(MemberVO menu) {
		return service.inputNoticeMenu(menu);
	}
}
